from .worker import IWorker, WorkerFactory
from .io_tags import Done, UpdateParams, Reset, Rewind

import os


class Worker_RWKV(IWorker):
    MODELS = [
        'raven-3B-ChnEng-2048',
    ]

    PARAMS = dict(
            token_count = 400,
            temperature = 1.0,
            top_p = 0.7,
            top_k = 0,
            alpha_frequency = 0.25,
            alpha_presence = 0.25,
            token_ban = (0,),
            token_stop = (),
            chunk_len = 256,
    )

    _MODEL_DETAILS = {
        'raven-3B-ChnEng-2048': (
            '/home/bate/Downloads/RWKV-4-Raven-3B-v6-ChnEng-20230401-ctx2048.pth',
            'cuda fp16i8 -> cuda fp16 *4',
        ),
    }

    def _worker(self):
        import torch, gc

        from rwkv.model import RWKV
        from rwkv.utils import PIPELINE, PIPELINE_ARGS

        os.environ["RWKV_JIT_ON"] = '1'
        os.environ["RWKV_CUDA_ON"] = '1'

        model, strategy = self._MODEL_DETAILS[self._model]
        model = RWKV(model=model, strategy=strategy)
        pipeline = PIPELINE(model, "/home/bate/Codes/ChatRWKV/20B_tokenizer.json")

        print('Starting RWKV worker...')

        ctx = ''
        last_ctx = ''
        while True:
            gc.collect()
            torch.cuda.empty_cache()

            question = self._questions.get()
            params = dict(self._params)
            token_count = params.pop('token_count')

            if isinstance(question, Reset):
                ctx = ''
                continue
            if isinstance(question, Rewind):
                ctx = last_ctx
                continue
            elif isinstance(question, UpdateParams):
                self._params = dict(question.params)
                continue

            last_ctx = ctx
            if question.startswith('+rwkv'):
                if len(ctx):
                    ctx += '\n'
                ctx += question + '\n'
            else:
                if not len(ctx):
                    ctx = '+rwkv_gen Q & A\n'
                else:
                    ctx += '\n'
                ctx += 'Question:\n' + question + '\nAnswer:\n'

            args = PIPELINE_ARGS(**params)

            answer = ''
            def callback(part):
                nonlocal answer
                if len(part):
                    print(part, end='', flush=True)
                    answer += part
                    self._answers.put(part)

            pipeline.generate(ctx, token_count=token_count, args=args, callback=callback)
            print()
            ctx += answer
            self._answers.put(Done())


WorkerFactory.instance().register_worker_type('RWKV', Worker_RWKV)

__all__ = []

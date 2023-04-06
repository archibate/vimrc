import os

from .worker import IWorker, WorkerFactory
from .io_tags import Done, UpdateParams, Reset, Rewind


class Worker_RWKV(IWorker):
    MODELS = [
        'raven-3B',
        'raven-14B',
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

########################################################################################################
#
# Use '/' in model path, instead of '\'. Use ctx4096 models if you need long ctx.
#
# fp16 = good for GPU (!!! DOES NOT support CPU !!!)
# fp32 = good for CPU
# bf16 = worse accuracy, supports CPU
# xxxi8 (example: fp16i8, fp32i8) = xxx with int8 quantization to save 50% VRAM/RAM, slower, slightly less accuracy
#
# We consider [ln_out+head] to be an extra layer, so L12-D768 (169M) has "13" layers, L24-D2048 (1.5B) has "25" layers, etc.
# Strategy Examples: (device = cpu/cuda/cuda:0/cuda:1/...)
# 'cpu fp32' = all layers cpu fp32
# 'cuda fp16' = all layers cuda fp16
# 'cuda fp16i8' = all layers cuda fp16 with int8 quantization
# 'cuda fp16i8 *10 -> cpu fp32' = first 10 layers cuda fp16i8, then cpu fp32 (increase 10 for better speed)
# 'cuda:0 fp16 *10 -> cuda:1 fp16 *8 -> cpu fp32' = first 10 layers cuda:0 fp16, then 8 layers cuda:1 fp16, then cpu fp32
#
# Basic Strategy Guide: (fp16i8 works for any GPU)
# 100% VRAM = 'cuda fp16'                   # all layers cuda fp16
#  98% VRAM = 'cuda fp16i8 *1 -> cuda fp16' # first 1 layer  cuda fp16i8, then cuda fp16
#  96% VRAM = 'cuda fp16i8 *2 -> cuda fp16' # first 2 layers cuda fp16i8, then cuda fp16
#  94% VRAM = 'cuda fp16i8 *3 -> cuda fp16' # first 3 layers cuda fp16i8, then cuda fp16
#  ...
#  50% VRAM = 'cuda fp16i8'                 # all layers cuda fp16i8
#  48% VRAM = 'cuda fp16i8 -> cpu fp32 *1'  # most layers cuda fp16i8, last 1 layer  cpu fp32
#  46% VRAM = 'cuda fp16i8 -> cpu fp32 *2'  # most layers cuda fp16i8, last 2 layers cpu fp32
#  44% VRAM = 'cuda fp16i8 -> cpu fp32 *3'  # most layers cuda fp16i8, last 3 layers cpu fp32
#  ...
#   0% VRAM = 'cpu fp32'                    # all layers cpu fp32
#
# Use '+' for STREAM mode, which can save VRAM too, and it is sometimes faster
# 'cuda fp16i8 *10+' = first 10 layers cuda fp16i8, then fp16i8 stream the rest to it (increase 10 for better speed)
#
# Extreme STREAM: 3G VRAM is enough to run RWKV 14B (slow. will be faster in future)
# 'cuda fp16i8 *0+ -> cpu fp32 *1' = stream all layers cuda fp16i8, last 1 layer [ln_out+head] cpu fp32
#
# ########################################################################################################
    _MODEL_DETAILS = {
        'raven-3B': (
            '/home/bate/Downloads/RWKV-4-Raven-3B-v6-ChnEng-20230401-ctx2048.pth',
            'cuda fp16i8 -> cuda fp16 *4',
        ),
        'raven-14B': (
            '/home/bate/Downloads/RWKV-4-Raven-14B-v6-Eng-20230401-ctx4096.pth',
            'cuda fp16i8 *0+ -> cpu fp32 *1',
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

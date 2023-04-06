import time

from .worker import IWorker, WorkerFactory
from .io_tags import Done, UpdateParams, Reset, Rewind


class Worker_Dummy(IWorker):
    MODELS = [
        'lazy',
        'crasher',
        'repeater',
    ]

    PARAMS = dict(
            token_count = 200,
            temperature = 1.0,
    )

    def _worker(self):
        ctx = ''
        last_ctx = ''
        print('dummy started')

        while True:
            print('dummy waiting for question')
            question = self._questions.get()
            print('dummy got question:')
            print(question)

            if isinstance(question, Reset):
                ctx = ''
                continue
            if isinstance(question, Rewind):
                ctx = last_ctx
                continue
            elif isinstance(question, UpdateParams):
                self._params = dict(question.params)
                continue
            else:
                if not len(ctx):
                    ctx = 'Expert Q & A\n'
                else:
                    ctx += '\n'
                ctx += 'Question:\n' + question + '\nAnswer:\n'

            answer = ''
            def callback(part):
                nonlocal answer
                if len(part):
                    print(part, end='', flush=True)
                    answer += part
                    self._answers.put(part)
                    import random
                    time.sleep(random.randint(1, 80) / 1000)

            last_ctx = ctx
            print('dummy got context:')
            print(ctx)
            if self._model == 'repeater':
                for c in question:
                    callback(c)
            if self._model == 'crasher':
                callback('execuse')
                callback(' me')
                callback('?')
                callback(' I')
                callback(' am')
                callback(' going')
                callback(' to')
                raise RuntimeError('crasher bot crashed!')
            else:
                callback('execuse')
                callback(' me')
                callback('?')
                callback(' I')
                callback(' am')
                callback(' a')
                callback(' dummy')
                callback(' bot')
                callback('.')
            print()
            ctx += answer
            print('dummy replies:')
            print(answer)
            self._answers.put(Done())


WorkerFactory.instance().register_worker_type('Dummy', Worker_Dummy)

__all__ = []

import time

from .worker import IWorker, WorkerFactory
from .io_tags import Done, UpdateParams, Reset


class Worker_Dummy(IWorker):
    MODELS = [
        'lazy-dummy',
        'repeater-dummy',
    ]

    PARAMS = dict(
            token_count = 200,
            temperature = 1.0,
    )

    def _worker(self):
        ctx = ''
        print('dummy started')
        while True:
            print('dummy waiting for question')
            question = self._questions.get()
            print('dummy got question:')
            print(question)

            if isinstance(question, Reset):
                ctx = ''
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
                    time.sleep(0.42)

            print('dummy got context:')
            print(ctx)
            if self._model == 'repeater-dummy':
                for c in question:
                    callback(c)
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

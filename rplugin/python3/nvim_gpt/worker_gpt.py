from .worker import IWorker, WorkerFactory
from .io_tags import Done, UpdateParams, Reset, Rewind


class Worker_ChatGPT(IWorker):
    MODELS = [
        'creative',
        'balanced',
        'percise',
    ]

    PARAMS = dict(
    )

    def _worker(self):
        print('ChatGPT started')
        import openai

        messages = []
        while True:
            print('ChatGPT waiting for question')
            question = self._questions.get()
            print('ChatGPT got question:')
            print(question)

            if isinstance(question, Reset):
                messages = []
                continue
            elif isinstance(question, UpdateParams):
                self._params = dict(question.params)
                continue

            messages.append({
                'role': 'user',
                'content': question,
            })

            print('ChatGPT starts request...')
            completion = openai.Completion.create(model=self._model, messages=messages)

            print('ChatGPT replies:')
            response = completion.choices[0].message  # type: ignore
            messages.append(response)
            self._answers.put(response.content)
            self._answers.put(Done())

        # sync.function(bot.close)()

    @staticmethod
    async def _async_ask(bot, question, style, callback):
        wrote = 0
        async for final, response in bot.ask_stream(prompt=question, conversation_style=style):
            if not final:
                callback(response[wrote:])
                wrote = len(response)


WorkerFactory.instance().register_worker_type('ChatGPT', Worker_ChatGPT)

__all__ = []

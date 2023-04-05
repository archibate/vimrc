import async_to_sync as sync
import asyncio
import json
import os

from .worker import IWorker, WorkerFactory
from .io_tags import Done, UpdateParams, Reset


def get_api():
    import EdgeGPT
    return EdgeGPT


class Worker_BingAI(IWorker):
    MODELS = [
        'creative',
        'balanced',
        'percise',
    ]

    PARAMS = dict(
    )

    def _worker(self):
        print('BingAI started')
        api = get_api()
        cookies_path = '~/.bing-cookies.json'
        cookies_path = os.path.expanduser(cookies_path)
        with open(cookies_path, 'r') as f:
            cookies = json.load(f)
        bot = api.Chatbot(cookies=cookies)

        while True:
            print('BingAI waiting for question')
            question = self._questions.get()
            print('BingAI got question:')
            print(question)

            if isinstance(question, Reset):
                sync.function(bot.reset)
                continue
            elif isinstance(question, UpdateParams):
                self._params = dict(question.params)
                continue

            answer = ''
            def callback(part):
                nonlocal answer
                if len(part):
                    print(part, end='', flush=True)
                    answer += part
                    self._answers.put(part)

            print('BingAI starts request...')
            style = getattr(api.ConversationStyle, self._model)
            sync.function(self._async_ask)(bot, question, style, callback)

            print('BingAI replies:')
            print(answer)
            self._answers.put(Done())

        # sync.function(bot.close)()

    @staticmethod
    async def _async_ask(bot, question, style, callback):
        wrote = 0
        async for final, response in bot.ask_stream(prompt=question, conversation_style=style):
            if not final:
                callback(response[wrote:])
                wrote = len(response)


WorkerFactory.instance().register_worker_type('BingAI', Worker_BingAI)

__all__ = []

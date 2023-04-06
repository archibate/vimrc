import threading
import queue

from .io_tags import Reset, Rewind, UpdateParams, Shutdown


class IWorker:
    MODELS = NotImplemented
    PARAMS = NotImplemented

    def __init__(self, model, params):
        self._answers = queue.Queue()
        self._questions = queue.Queue(maxsize=1)
        self._pending_questions = queue.Queue()
        self._task = threading.Thread(target=self._worker)
        self._model = model
        self._params = dict(self.PARAMS)
        self._params.update(params)
        self._task.start()

    def push_question(self, question):
        if not self._task.is_alive():
            print('try restarting worker')
            self._task = threading.Thread(target=self._worker)
            self._task.start()
        try:
            if not self._pending_questions.empty():
                old_question = self._pending_questions.get_nowait()
                self._questions.put_nowait(old_question)
                return
            self._questions.put_nowait(question)
        except queue.Full:
            self._pending_questions.put_nowait(question)

    def try_pop_answer(self):
        try:
            c = self._answers.get_nowait()
        except queue.Empty:
            if not self._task.is_alive():
                return Shutdown()
            else:
                return None
        else:
            return c  # maybe Done

    def push_reset(self):
        self.push_question(Reset())

    def push_rewind(self):
        self.push_question(Rewind())

    def may_update_params(self, params):
        new_params = dict(self.PARAMS)
        new_params.update(params)
        if new_params != self._params:
            self._questions.put_nowait(UpdateParams(new_params))

    def _worker(self):
        raise NotImplementedError


class WorkerFactory:
    class __private_construct: pass

    def __init__(self, __private_construct):
        assert __private_construct is self.__private_construct
        self._worker_instances = {}
        self._worker_factories = {}
        self._worker_type_of_model = {}
        self._model_list = []

    def register_worker_type(self, worker_type, constructor):
        self._worker_factories[worker_type] = constructor
        for model in constructor.MODELS:
            assert model not in self._worker_type_of_model, 'worker model name conflict'
            self._worker_type_of_model[model] = worker_type
            self._model_list.append(model)

    def model_worker_type(self, model):
        return self._worker_type_of_model[model]

    def available_models(self):
        return list(self._model_list)

    def get_worker(self, model, params):
        if model in self._worker_instances:
            worker = self._worker_instances[model]
            worker.may_update_params(params)
            return worker
        worker_type = self._worker_type_of_model[model]
        worker = self._worker_factories[worker_type](model, params)
        self._worker_instances[model] = worker
        return worker

    @classmethod
    def instance(cls):
        if not hasattr(cls, '_instance'):
            cls._instance = cls(cls.__private_construct)
        return cls._instance


__all__ = ['IWorker', 'WorkerFactory']

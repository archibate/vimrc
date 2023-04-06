from .worker import IWorker, WorkerFactory

from . import worker_rwkv as _
from . import worker_dummy as _
from . import worker_bing as _

def get_worker(model, params) -> IWorker:
    return WorkerFactory.instance().get_worker(model, params)

def available_models() -> list[str]:
    return WorkerFactory.instance().available_models()

def model_worker_type(model) -> str:
    return WorkerFactory.instance().model_worker_type(model)

__all__ = ['get_worker', 'available_models', 'model_worker_type']

from .worker import IWorker, WorkerFactory

from . import worker_rwkv as _
from . import worker_dummy as _
from . import worker_bing as _

def get_worker(worker_type, model, params) -> IWorker:
    return WorkerFactory.instance().get_worker(worker_type, model, params)

__all__ = ['get_worker']

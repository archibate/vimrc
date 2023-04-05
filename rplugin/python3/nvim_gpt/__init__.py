from .logging import LogSystem
LogSystem.instance()  # log system must start before everything

from .plugin import GPTPlugin


__all__ = ['GPTPlugin']

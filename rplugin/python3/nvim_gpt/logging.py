import sys
import builtins
import time

class LogSystem:
    class __private_construct: pass

    def __init__(self, __private_construct):
        assert __private_construct is self.__private_construct
        self._sys_stdout = sys.stdout
        self._sys_stderr = sys.stderr
        self._builtin_print = builtins.print
        builtins.print = self.print
        self._buffer = open('/tmp/gpt.log', 'a')
        self._buffer.write('====== ' + str(time.ctime()) + ' =====\n')
        sys.stdout = self._buffer
        sys.stderr = self._buffer

    def print(self, *args, **kwargs):
        if 'file' not in kwargs:
            kwargs['file'] = self._buffer
        kwargs['flush'] = True
        self._builtin_print(*args, **kwargs)

    def __del__(self):
        sys.stdout = self._sys_stdout
        sys.stderr = self._sys_stderr
        builtins.print = self._builtin_print
        self._buffer.close()

    @classmethod
    def instance(cls):
        if not hasattr(cls, '_instance'):
            cls._instance = cls(cls.__private_construct)
        return cls._instance

    def read_log(self):
        with open('/tmp/gpt.log', 'r') as f:
            content = f.read()
        return content

__all__ = ['LogSystem']

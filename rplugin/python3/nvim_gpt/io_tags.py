class Reset:
    pass

class Rewind:
    pass

class UpdateParams:
    def __init__(self, params):
        self.params = params

class Done:
    pass


__all__ = [
    'Reset',
    'Rewind',
    'UpdateParams',
    'Done',
]

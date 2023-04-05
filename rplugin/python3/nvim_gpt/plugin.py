import neovim
import contextlib
import threading
import random

from .io_tags import Done
from .logging import LogSystem


@neovim.plugin
class GPTPlugin:
    def __init__(self, nvim):
        print('GPT plugin started')
        self.nvim = nvim

        self._state = 'idle'  # options: idle, running
        self._cursor_counter = 0
        self._qa_count = 0
        self._last_question = None
        self._last_question_pos = None
        self._has_added_keymaps = False

        self._bot_type = 'BingAI'  # options: ChatGPT, BingAI, RWKV, Dummy
        self._model = 'balanced'  # specific models depending on bot types
        if 0:
            self._bot_type = 'RWKV'
            self._model = 'raven-3B-ChnEng-2048'
        if 0:
            self._bot_type = 'Dummy'
            self._model = 'repeater-dummy'
        self._params = {}     # specific parameters like temperature depends on bot types
        self._cursors = '|/_\\'  # '_ ' for blinking '_' and ' '
        self._code_quote = '{question}\n```{filetype}\n{code}\n```'
        self._question_title = '# Question {}'
        self._answer_title = '# Answer {}'
        self._mutex = threading.Lock()
        self._welcome_messages = [
            "This is {}, how can I help you?",
            "Here is {}, how can I help you?",
            "This is {}, any question today?",
            "Here is {}, any question today?",
            "Here is {}, what's the problem?",
            "{}! What's wrong with the code?",
            "{} coming! Need help in coding?",
            "{} is glad to help in your job!",
            "{} here! Looking for some help?",
            "{}! Nice to meet you! Question?",
            "Coding? Worry not, just ask {}!",
            "Anything may {} help? Just ask!",
        ]
        self._window_width = 40
        self._window_options = {
            'wrap': True,
            'list': False,
            'cursorline': True,
            'number': False,
            'relativenumber': False,
        }
        self._lock_last_line = 'last-char'  # options: none, last-char, last-line, force
        self._update_interval = 150         # milliseconds

    @neovim.command('GPTSuggestedKeymaps')
    def gpt_suggested_keymaps(self):
        from .keymaps import suggested_keymaps
        for line in suggested_keymaps.splitlines():
            if line:
                print('adding keymap:', line)
                self.nvim.command(line)
        self._has_added_keymaps = True

    def get_bot(self):
        from .workers import get_worker
        return get_worker(self._bot_type, self._model, self._params)

    @neovim.command('GPTLog')
    def gpt_log(self):
        with self._critical_section():
            bufnr = self.nvim.eval('bufnr("GPTLog")')
            if bufnr == -1:
                self.nvim.command('aboveleft new')
                buffer = self.nvim.current.buffer
                buffer.name = 'GPTLog'
                buffer.options['buftype'] = 'nofile'
                buffer.options['bufhidden'] = 'wipe'
                buffer.options['swapfile'] = False
                buffer[:] = LogSystem.instance().read_log().split('\n')
                buffer.options['modifiable'] = False
            else:
                winnr = self.nvim.eval('bufwinnr(' + str(bufnr) + ')')
                if winnr == -1:
                    self.nvim.command('rightbelow split')
                    self.nvim.command('buffer ' + str(bufnr))
                else:
                    self.nvim.command(str(winnr) + 'windo buffer')
                buffer = self.nvim.buffers[bufnr]
                buffer.options['modifiable'] = True
                try:
                    buffer[:] = LogSystem.instance().read_log().split('\n')
                finally:
                    buffer.options['modifiable'] = False
            self.nvim.command('norm! G')

    @neovim.command('GPT')
    def gpt_toggle(self):
        with self._critical_section():
            self._do_gpt_open(toggle=True)

    def _do_gpt_open(self, toggle=False):
        bufnr = self.nvim.eval('bufnr("GPTAsk")')
        if bufnr == -1:
            self.nvim.command('rightbelow vnew')
            buffer = self.nvim.current.buffer
            window = self.nvim.current.window
            buffer.name = 'GPTAsk'
            buffer.options['buftype'] = 'nofile'
            buffer.options['filetype'] = 'markdown'
            buffer.options['bufhidden'] = 'hide'
            buffer.options['modifiable'] = False
            buffer.options['swapfile'] = False
            window.width = self._window_width
            for k, v in self._window_options.items():
                window.options[k] = v
            self._set_welcome_message()
        elif toggle:
            winnr = self.nvim.eval('bufwinnr(' + str(bufnr) + ')')
            if winnr == -1:
                self.nvim.command('rightbelow vsplit')
                self.nvim.command('buffer ' + str(bufnr))
            else:
                winnr = self.nvim.eval('bufwinnr(' + str(bufnr) + ')')
                self.nvim.command(str(winnr) + 'wincmd q')
        else:
            winnr = self.nvim.eval('bufwinnr(' + str(bufnr) + ')')
            if winnr == -1:
                self.nvim.command('rightbelow vsplit')
                self.nvim.command('buffer ' + str(bufnr))
                self.nvim.current.window.width = self._window_width
            else:
                self.nvim.command(str(winnr) + 'windo buffer')

    @neovim.command('GPTReset')
    def gpt_reset(self):
        with self._critical_section():
            if self._state != 'idle':
                return
            # _do_gpt_stop() seems get the bot into a corrupted state, simply use return as a temporary fix
            # self._do_gpt_stop()
            self._do_gpt_open()
            self._qa_count = 0
            self._set_welcome_message()
            bot = self.get_bot()
            bot.push_reset()

    @neovim.command('GPTStop')
    def gpt_stop(self):
        with self._critical_section():
            self._do_gpt_stop()

    def _do_gpt_stop(self):
        if self._state == 'running':
            self._rid_last_line_cursor()
            self._transit_state('idle')

    @neovim.command('GPTAsk', nargs='*')  # type: ignore
    def gpt_ask(self, args):
        with self._critical_section():
            if self._state != 'idle':
                return
            # _do_gpt_stop() seems get the bot into a corrupted state, simply use return as a temporary fix
            # self._do_gpt_stop()
            question = self._compose_question(args)
            if not len(question):
                self.nvim.command('echo "Please provide your question"')
                return
            self._do_gpt_open()
            self._submit_question(question)

    @neovim.command('GPTCode', nargs='*', range=True)  # type: ignore
    def gpt_code(self, args, range):
        with self._critical_section():
            if self._state != 'idle':
                return
            # _do_gpt_stop() seems get the bot into a corrupted state, simply use return as a temporary fix
            # self._do_gpt_stop()
            question = self._compose_question(args, range)
            if not len(question):
                self.nvim.command('echo "Please provide your question"')
                return
            self._do_gpt_open()
            self._submit_question(question)

    @neovim.command('GPTRegenerate')
    def gpt_regenerate(self):
        with self._critical_section():
            if self._state != 'idle':
                return
            # _do_gpt_stop() seems get the bot into a corrupted state, simply use return as a temporary fix
            # self._do_gpt_stop()
            if self._last_question is None:
                self.nvim.command('echo "No previous question asked"')
                return
            self._do_gpt_open()
            self._submit_question(self._last_question, regenerate=True)

    def _submit_question(self, question, regenerate=False):
        if not regenerate:
            self._qa_count += 1
            qa_count = self._qa_count
        else:
            qa_count = str(self._qa_count) + ' (Regenerated)'
        self._last_question = question
        question_ml = question.split('\n')
        question_ml = ['', self._question_title.format(qa_count), ''] + question_ml
        question_ml += ['', self._answer_title.format(qa_count), '']
        if len(self._cursors):
            self._cursor_counter = 0
            question_ml.append(self._cursors[self._cursor_counter])
        else:
            question_ml.append('')
        self._append_buffer(question_ml)
        bot = self.get_bot()
        if regenerate:
            bot.push_rewind()
        bot.push_question(question)
        self._transit_state('running')
        self._lock_cursor_to_end()

    @neovim.command('GPTSync')
    def gpt_sync(self):
        with self._critical_section():
            if self.nvim.eval('bufnr("GPTAsk")') == -1:
                return
            bot = self.get_bot()
            full_answer = ''
            self._cursor_counter = (self._cursor_counter + 1) % len(self._cursors)
            while True:
                answer = bot.try_pop_answer()
                if answer is None:  # none means further queue pop would be blocking
                    break
                if isinstance(answer, Done):  # done means end of a round of answer
                    self._append_last_line(full_answer)
                    self._rid_last_line_cursor()
                    self._transit_state('idle')
                    return
                full_answer += answer
                # break  # remove this line
            self._append_last_line(full_answer)

    def _transit_state(self, state):
        if state == 'idle':
            assert self._state == 'running'
            self.nvim.command('lua if _gpt_sync_timer then _gpt_sync_timer:stop() end')
        elif state == 'running':
            assert self._state == 'idle'
            self.nvim.command('lua _gpt_sync_timer = vim.loop.new_timer()')
            self.nvim.command('lua _gpt_sync_timer:start({interval}, {interval}, vim.schedule_wrap(function () vim.cmd [[GPTSync]] end))'.format(interval=self._update_interval))
        self._state = state

    def _append_last_line(self, content):
        if not len(content):
            if len(self._cursors):
                with self._modifiable_buffer() as buffer:
                    # Just worth it to make it so fxxking sense of technology!!!!
                    last_line = buffer[-1]
                    if len(last_line) and last_line[-1] in self._cursors:
                        last_line = last_line[:-1]
                    buffer[-1] = last_line + self._cursors[self._cursor_counter]
            return
        lines = content.split('\n')
        if not len(lines):
            return
        with self._modifiable_buffer() as buffer:
            last_line = buffer[-1]
            if len(self._cursors):
                lines[-1] = lines[-1] + self._cursors[self._cursor_counter]
            if len(self._cursors):
                if len(last_line) and last_line[-1] in self._cursors:
                    last_line = last_line[:-1]
                buffer[-1] = last_line + lines[0]
            else:
                buffer[-1] = last_line + lines[0]
            if len(lines) > 1:
                buffer.append(lines[1:])
        self._lock_cursor_to_end()

    def _lock_cursor_to_end(self):
        if self.nvim.eval('bufnr("%") != bufnr("GPTAsk")'):
            return
        if self._lock_last_line != 'force':
            if self._lock_last_line in ('last-char', 'last-line'):
                buffer = self._get_buffer()
                if len(buffer) > self.nvim.eval('getcurpos()[1]'):
                    return
                if self._lock_last_line == 'last-char':
                    if len(buffer[-1]) > self.nvim.eval('getcurpos()[2]'):
                        return
        self.nvim.command('norm! G$')

    def _rid_last_line_cursor(self):
        if not len(self._cursors):
            return
        with self._modifiable_buffer() as buffer:
            last_line = buffer[-1]
            if len(last_line) and last_line[-1] in self._cursors:
                buffer[-1] = last_line[:-1]

    def _append_buffer(self, lines):
        with self._modifiable_buffer() as buffer:
            buffer.append(lines)

    def _set_buffer(self, lines):
        with self._modifiable_buffer() as buffer:
            buffer[:] = lines

    def _get_buffer(self):
        bufnr = self.nvim.eval('bufnr("GPTAsk")')
        if bufnr == -1:
            raise RuntimeError('GPT window not open, please :GPTOpen first')
        return self.nvim.buffers[bufnr]

    @contextlib.contextmanager
    def _modifiable_buffer(self):
        buffer = self._get_buffer()
        buffer.options['modifiable'] = True
        try:
            yield buffer
        finally:
            buffer.options['modifiable'] = False

    def _compose_question(self, args, range=None):
        question = ' '.join(args)
        if range is not None:
            buffer = self.nvim.current.buffer
            code = '\n'.join(buffer[range[0]-1:range[1]])
            if '{filetype}' in self._code_quote:
                filetype = self.nvim.current.buffer.options['filetype']
                if filetype == 'markdown':
                    ft = None
                    for i in range(1, min(len(buffer) + 1, range[0])):
                        line = buffer[i - 1]
                        if line.startswith('```'):
                            if ft is None:
                                ft = line[3:]
                            else:
                                ft = None
                    filetype = ft
                question = self._code_quote.format(question=question, code=code, filetype=filetype)
            else:
                question = self._code_quote.format(question=question, code=code)
        return question

    def _set_welcome_message(self):
        self._set_buffer([random.choice(self._welcome_messages).format(self._bot_type)])
        self._lock_cursor_to_end()

    @contextlib.contextmanager
    def _critical_section(self):
        self._mutex.acquire()
        try:
            yield
        finally:
            self._mutex.release()


__all__ = ['GPTPlugin']

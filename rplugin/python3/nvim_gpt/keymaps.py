suggested_keymaps = '''
nnoremap {trigger} :GPTAsk<Space>
vnoremap {trigger} :GPTCode<Space>
nnoremap <silent> g{trigger} <Cmd>.GPTCode<CR>
" nnoremap <silent> g{trigger} <Cmd>exec ":GPTAsk " . getline('.')<CR>
nnoremap <silent> gs{trigger} <Cmd>exec ":GPTAsk " . expand('<cword>')<CR>
nnoremap <silent> gS{trigger} <Cmd>%GPTCode<CR>
'''

gpt_window_keymaps = '''
nnoremap <buffer> i :GPTAsk<Space>
nnoremap <buffer><silent> a <Cmd>GPTPaste<CR>
nnoremap <buffer><silent> r <Cmd>GPTRegenerate<CR>
nnoremap <buffer><silent> d <Cmd>GPTReset<CR>
nnoremap <buffer><silent> <CR> <Cmd>wincmd q<CR>
'''

__all__ = ['suggested_keymaps', 'gpt_window_keymaps']

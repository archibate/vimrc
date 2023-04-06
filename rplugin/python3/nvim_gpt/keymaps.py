suggested_keymaps = '''
nnoremap {trigger} :GPTInput<Space>
vnoremap {trigger} :GPTCode<Space>
nnoremap <silent> g{trigger} <Cmd>.GPTCode<CR>
" nnoremap <silent> g{trigger} <Cmd>exec ":GPTInput " . getline('.')<CR>
nnoremap <silent> gs{trigger} <Cmd>exec ":GPTInput " . expand('<cword>')<CR>
nnoremap <silent> gS{trigger} <Cmd>%GPTCode<CR>
'''

gpt_window_keymaps = '''
nnoremap <buffer> i :GPTInput<Space>
nnoremap <buffer><silent> a <Cmd>GPTAccept<CR>
nnoremap <buffer><silent> r <Cmd>GPTRegenerate<CR>
nnoremap <buffer><silent> d <Cmd>GPTDiscard<CR>
nnoremap <buffer><silent> x <Cmd>GPTExecute<CR>
nnoremap <buffer><silent> <CR> <Cmd>wincmd q<CR>
'''

__all__ = ['suggested_keymaps', 'gpt_window_keymaps']

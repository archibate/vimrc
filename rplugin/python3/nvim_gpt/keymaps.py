suggested_keymaps = '''
" aAiIcxXuUsSdD=~[cxusd=~]prR oO<> <CR> <BS> <Space>
nnoremap <Tab><Tab> :GPT<CR>
nnoremap <Tab>a :GPTAsk<Space>
nnoremap <Tab>A :exec ":GPTAsk " . getline('.')<CR>
nnoremap <Tab>i :exec ":GPTAsk " . expand('<cword>')<CR>
nnoremap <Tab>I :exec ":GPTAsk " . expand('<cWORD>')<CR>
nnoremap <Tab>c :GPTCode<Space>
nnoremap <Tab>C :GPTCode<CR>
nnoremap <Tab>x :%GPTCode<Space>
nnoremap <Tab>X :%GPTCode<CR>
nnoremap <Tab>u :1,.GPTCode suggest what I am going to write next<CR>
nnoremap <Tab>U :1,.GPTCode<Space>
nnoremap <Tab>s :-8,.GPTCode suggest what I am going to write next<CR>
nnoremap <Tab>S :-8,.GPTCode<Space>
nnoremap <Tab>d :-7,+5GPTCode help me fix this error<CR>
nnoremap <Tab>D :-7,+5GPTCode<Space>
nnoremap <Tab>= :%GPTCode write a test for this code<CR>
nnoremap <Tab>~ :%GPTCode write a benchmark for this code<CR>
vnoremap <Tab>c :GPTCode<Space>
vnoremap <Tab>x :GPTCode explain this code step-by-step<CR>
vnoremap <Tab>u :GPTCode find possible bugs in this code<CR>
vnoremap <Tab>s :GPTCode implement the function with given call signature<CR>
vnoremap <Tab>d :GPTCode fix this error<CR>
vnoremap <Tab>= :GPTCode write a test for this code<CR>
vnoremap <Tab>~ :GPTCode write a benchmark for this code<CR>
nnoremap <Tab>p :GPTPaste<CR>
nnoremap <Tab>P :GPTPaste!<CR>
nnoremap <Tab>r :GPTRegenerate<CR>
nnoremap <Tab>R :GPTReset<CR>
'''

__all__ = ['suggested_keymaps']

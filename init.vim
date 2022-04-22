if has('nvim')
lua require('archvim')
else
source '~/.vim/legacy.vim'
endif

if filereadable('.vim_localrc')
    source .vim_localrc
endif

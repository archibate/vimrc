if has('nvim')
"let g:archvim_predownload=1
lua require('archvim')
else
echoerr "You are using Vim, not NeoVim"
endif

if filereadable('.vim_localrc')
    source .vim_localrc
endif

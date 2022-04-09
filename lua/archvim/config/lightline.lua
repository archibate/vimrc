vim.cmd [[
set noshowmode
" lightline
let g:lightline = {
      \ 'active': {
      \   'left': [
      \             [ 'mode', 'paste', ],
      \             [ 'readonly', 'filename', 'modified', ],
      \             [ 'branch', ],
      \           ]
      \ },
      \ }
]]

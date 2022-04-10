-- neovim 6.1 required

require('archvim/plugins')

vim.cmd [[
set mouse=a
set nu rnu ru ls=2
set et sts=0 ts=4 sw=4
set listchars=tab:▸\ ,trail:⋅,extends:❯,precedes:❮
set showbreak=↪
set list
]]

vim.cmd [[colorscheme gruvbox]]

require('archvim/mappings')

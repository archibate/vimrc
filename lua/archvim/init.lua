-- neovim 6.1 required

vim.g.mapleader = ','

vim.cmd [[
set mouse=a
set nu rnu ru ls=2
set et sts=0 ts=4 sw=4
set signcolumn=yes
set listchars=tab:▸\ ,trail:⋅,extends:❯,precedes:❮
set showbreak=↪
set list
]]

require('archvim/plugins')

vim.cmd [[
set termguicolors
colorscheme gruvbox
]]

require('archvim/mappings')

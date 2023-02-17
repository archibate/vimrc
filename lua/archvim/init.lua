-- neovim 6.1 required

vim.g.mapleader = ','

vim.cmd [[
set mouse=a
set nu rnu ru ls=2
set et sts=0 ts=4 sw=4
set signcolumn=yes
set listchars=tab:▸\ ,trail:⋅,extends:❯,precedes:❮
set cinoptions=j1,(0,ws,Ws,g0
set showbreak=↪
set list
set clipboard+=unnamedplus
set switchbuf=useopen
]]

require('archvim/plugins')

vim.cmd [[
set termguicolors
colorscheme gruvbox
]]

require('archvim/mappings')

vim.g_printed = ''
vim.g_print = function(msg)
    vim.g_printed = vim.g_printed .. tostring(msg) .. '\n'
end
vim.g_dump = function()
    print(vim.g_printed)
end

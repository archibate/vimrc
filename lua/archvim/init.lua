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
vim.cmd [[
augroup disable_formatoptions_cro
autocmd!
autocmd FileType * set formatoptions-=cro
augroup end
]]
vim.cmd [[
augroup disable_swap_exists_warning
autocmd!
autocmd SwapExists * let v:swapchoice = "e"
augroup end
]]
vim.cmd [[
augroup goto_last_position_on_open
autocmd!
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
augroup end
]]

vim.g.mapleader = ','

vim.cmd [[
set mouse=a
set mousemodel=extend
set updatetime=1000
set nu nornu ru ls=2
set et sts=0 ts=4 sw=4
set signcolumn=number
" set bri wrap
set listchars=tab:▸\ ,trail:⋅,extends:❯,precedes:❮
set cinoptions=j1,(0,ws,Ws,g0,:1,=0
set showbreak=↪
set list
set clipboard+=unnamedplus
set switchbuf=useopen
set exrc
]]

vim.cmd [[
augroup disable_formatoptions_cro
autocmd!
autocmd BufEnter * setlocal formatoptions-=cro
augroup end
]]

vim.cmd [[
augroup disable_swap_exists_warning
autocmd!
autocmd SwapExists * let v:swapchoice = "e"
augroup end
]]

vim.cmd [[
set termguicolors
colorscheme gruvbox
hi Normal guibg=none
" hi NormalFloat guifg=#928374 guibg=#282828
" hi WinSeparator guibg=none
" hi TreesitterContext gui=NONE guibg=#282828
" hi TreesitterContextBottom gui=underline guisp=Grey
]]

-- vim.g_printed = ''
-- vim.g_print = function(msg)
--     vim.g_printed = vim.g_printed .. tostring(msg) .. '\n'
-- end
-- vim.g_dump = function()
--     print(vim.g_printed)
-- end

vim.lsp.set_log_level("off")

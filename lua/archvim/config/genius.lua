require'genius'.setup {
    completion_delay_ms = -1,
}

vim.cmd [[
inoremap <C-Space> <Cmd>GeniusComplete<CR>
]]

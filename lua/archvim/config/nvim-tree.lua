require'nvim-tree'.setup{
    auto_reload_on_write = true,
    hijack_cursor = false,
    open_on_setup = true,
    open_on_setup_file = true,
}

vim.cmd [[
augroup exit_if_nvim_tree_only_tab
autocmd!
autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | wqa | endif
augroup end
]]

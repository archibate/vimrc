require'nvim-tree'.setup {
    auto_reload_on_write = true,
    hijack_cursor = false,
    open_on_setup = false,
    open_on_setup_file = true,
    view = {
        width = 30,
        height = 30,
        side = "left",
        color = "#3f0af0",
        preserve_window_proportions = false,
    },
}

vim.cmd [[
augroup exit_if_nvim_tree_only_tab
autocmd!
autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | wqa | endif
augroup end
]]

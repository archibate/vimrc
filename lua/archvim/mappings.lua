
-- Functional wrapper for mapping custom keybindings
function map(mode, lhs, rhs, opts)
    if type(mode) == 'table' then
        for i = 1, #mode do
            map(mode[i], lhs, rhs, opts)
        end
        return
    end
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map({"v", "n"}, "H", "(v:count == 0 || v:count == 1 ? '^^' : '^^' . (v:count - 1) . 'l')", { silent = true, expr = true })
map({"v", "n"}, "L", "(v:count == 0 || v:count == 1 ? '^$' : '^$' . (v:count - 1) . 'h')", { silent = true, expr = true })
map("n", "<F4>", "<cmd>wa<CR>")
-- map("n", "<F9>", "<cmd>PackerInstall<CR>")
-- map("n", "<F21>", "<cmd>PackerUpdate<CR>")
-- map("n", "<F10>", "<cmd>PackerCompile<CR>")
map("n", "<Space>", "<cmd>nohlsearch<CR><Space>", { silent = true })
map("i", "kj", "<Esc>", { silent = true })

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

return map

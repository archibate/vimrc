
-- Functional wrapper for mapping custom keybindings
function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map("n", "<F4>", ":<C-u>wa<CR>")
map("n", "<F5>", ":<C-u>AsyncTasks project-build project-run<CR>")
map("n", "<F6>", ":<C-u>AsyncTask project-build<CR>")
map("n", "<F7>", ":<C-u>AsyncTasks file-build file-run<CR>")
map("n", "<Space>", ":<C-u>nohlsearch<CR><Space>", { silent = true })

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


-- Functional wrapper for mapping custom keybindings
local function map(mode, lhs, rhs, opts)
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

map({"v", "n"}, "gh", "(v:count == 0 || v:count == 1 ? '^^' : '^^' . (v:count - 1) . 'l')", { silent = true, expr = true })
map({"v", "n"}, "gl", "(v:count == 0 || v:count == 1 ? '^$' : '^$' . (v:count - 1) . 'h')", { silent = true, expr = true })
map({"v", "n", "i"}, "<F4>", "<cmd>wa<CR>")
-- map("n", "<F9>", "<cmd>cp<CR>")
-- map("n", "<F10>", "<cmd>cn<CR>")
map({"v", "n", "i"}, "<F12>", "<cmd>nohlsearch|TroubleToggle<CR>", {silent = true })
map({"v", "n", "i"}, "<F6>", "<cmd>GPTToggle<CR>", { silent = true })
-- map({"v", "n"}, "<CR>", "<cmd>nohlsearch<CR>", { silent = true })
map("i", "kj", "<Esc>", { silent = true })
map("n", "Z", "ZZ", { silent = true })
map("v", "Z", "<Esc>", { silent = true })
map("x", "gq", "<cmd>Neoformat<CR>", { silent = true })
map({"v", "n", "i"}, "<F10>", "<cmd>Neoformat<CR>", { silent = true })
-- map("n", "Q", "<cmd>wa<CR><cmd>qa!<CR>", { silent = true })

-- vim.cmd [[
-- command! -nargs=0 A :ClangdSwitchSourceHeader
-- command! -nargs=? F :Neoformat <f-args>
-- ]]

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

-- vim.api.nvim_create_autocmd({"VimEnter"}, {
--     -- disable_n_more_files_to_edit
--     callback = function (data)
--         local no_name = data.file == "" and vim.bo[data.buf].buftype == ""
--         if not no_name then
--             -- vim.cmd [[ args % ]]
--         end
--     end,
-- })

vim.keymap.set({'v', 'n', 'i', 't'}, '<C-h>', [[<Cmd>wincmd h<CR>]])
vim.keymap.set({'v', 'n', 'i', 't'}, '<C-j>', [[<Cmd>wincmd j<CR>]])
vim.keymap.set({'v', 'n', 'i', 't'}, '<C-k>', [[<Cmd>wincmd k<CR>]])
vim.keymap.set({'v', 'n', 'i', 't'}, '<C-l>', [[<Cmd>wincmd l<CR>]])
vim.keymap.set({'n'}, '<esc>', [[<Cmd>nohls<CR><esc>]], { noremap = true })
vim.keymap.set('t', '<esc>', [[<C-\><C-n>]])
-- vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)

-- vim.keymap.set('i', '<M-]>', [[<Plug>(copilot-next)]])
-- vim.keymap.set('i', '<M-[>', [[<Plug>(copilot-previous)]])
-- vim.keymap.set('i', '<M-/>', [[<Plug>(copilot-suggest)]])

local _gpt_add_key_map_timer = vim.loop.new_timer()
_gpt_add_key_map_timer:start(100, 100, vim.schedule_wrap(function ()
    if _gpt_add_key_map_timer and pcall(function () vim.cmd [[GPTSuggestedKeymaps]] end) then
        _gpt_add_key_map_timer:stop()
        _gpt_add_key_map_timer = nil
    end
end))

vim.cmd [[ hi Normal guifg=#ebdbb2 guibg=none ]]

return map

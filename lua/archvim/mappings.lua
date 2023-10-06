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

map({"v", "n"}, "_", "+", { noremap = true })
map({"v", "n"}, "gh", "(v:count == 0 || v:count == 1 ? '^^' : '^^' . (v:count - 1) . 'l')", { silent = true, expr = true })
map({"v", "n"}, "gl", "(v:count == 0 || v:count == 1 ? '^$' : '^$' . (v:count - 1) . 'h')", { silent = true, expr = true })
map({"v", "n", "i"}, "<F4>", "<cmd>wa<CR>")
map({"v", "n", "i", "t"}, "<F7>", "<cmd>NvimTreeFindFileToggle<CR>")
map({"v", "n", "i", "t"}, "<F19>", "<cmd>TroubleToggle<CR>", { silent = true })
local found_cmake, cmake = pcall(require, "cmake-tools")
if found_cmake then
    map({"v", "n", "i", "t"}, "<F5>", "<cmd>wa<CR><cmd>if luaeval('require\"cmake-tools\".is_cmake_project()')|call execute('CMakeRun')|else|call execute('OverseerRun user.run_script')|endif<CR>", { silent = true })
    map({"v", "n", "i", "t"}, "<F17>", "<cmd>wa<CR><cmd>if luaeval('require\"cmake-tools\".is_cmake_project()')|call execute('CMakeStop')|else|call execute('OverseerClose')|endif<CR>", { silent = true })
else
    map({"v", "n", "i", "t"}, "<F5>", "<cmd>wa<CR><cmd>TermExec cmd='cmr'<CR>", { silent = true })
    map({"v", "n", "i", "t"}, "<F17>", "<cmd>wa<CR><cmd>TermExec cmd='!!'<CR>", { silent = true })
end
map({"v", "n", "i", "t"}, "<F10>", "<cmd>DapToggleBreakpoint<CR>", { silent = true })
map({"v", "n", "i", "t"}, "<F22>", "<cmd>DapToggleRepl<CR>", { silent = true })
map({"v", "n", "i", "t"}, "<F12>", "<cmd>DapStepOver<CR>", { silent = true })
map({"v", "n", "i", "t"}, "<F24>", "<cmd>DapStepInto<CR>", { silent = true })
map({"v", "n", "i", "t"}, "<C-F12>", "<cmd>DapStepOut<CR>", { silent = true })
if found_cmake then
    map({"v", "n", "i", "t"}, "<F9>", "<cmd>if luaeval('require\"cmake-tools\".is_cmake_project() and require\"dap\".session()==nil')|call execute('CMakeDebug')|else|call execute('DapContinue')|endif<CR>", { silent = true })
    map({"v", "n", "i", "t"}, "<F21>", "<cmd>if luaeval('require\"cmake-tools\".is_cmake_project() and require\"dap\".session()==nil')|call execute('CMakeStop')|else|call execute('DapTerminate')|endif<CR>", { silent = true })
else
    map({"v", "n", "i", "t"}, "<F9>", "<cmd>DapContinue<CR>", { silent = true })
    map({"v", "n", "i", "t"}, "<F21>", "<cmd>DapTerminate<CR>", { silent = true })
end
vim.keymap.set({'v', 'n', 'i', 't'}, '<Ins>', [[<Cmd>ZenMode<CR>]])
-- map({"v", "n"}, "<CR>", "<cmd>nohlsearch<CR>", { silent = true })
map("i", "kj", "<Esc>", { silent = true })
map("n", "Z", "<cmd>wa<CR><cmd>q<CR>", { silent = true })
map("v", "Z", "<Esc>", { silent = true })
-- map({"v", "n"}, "=", "<cmd>Neoformat<CR>", { silent = true })
-- map({"v", "n", "i"}, "<F10>", "<cmd>Neoformat<CR>", { silent = true })
-- map("n", "Q", "<cmd>wa<CR><cmd>qa!<CR>", { silent = true })

-- vim.cmd [[
-- command! -nargs=0 A :ClangdSwitchSourceHeader
-- command! -nargs=? F :Neoformat <f-args>
-- ]]

-- vim.api.nvim_create_autocmd({"VimEnter"}, {
--     -- disable_n_more_files_to_edit
--     callback = function (data)
--         local no_name = data.file == "" and vim.bo[data.buf].buftype == ""
--         if not no_name then
--             -- vim.cmd [[ args % ]]
--         end
--     end,
-- })

vim.keymap.set({'v', 'n', 'i', 't'}, '<C-h>', [[<C-w>h]])
vim.keymap.set({'v', 'n', 'i', 't'}, '<C-j>', [[<C-w>j]])
vim.keymap.set({'v', 'n', 'i', 't'}, '<C-k>', [[<C-w>k]])
vim.keymap.set({'v', 'n', 'i', 't'}, '<C-l>', [[<C-w>l]])
vim.keymap.set({'v', 'n', 'i', 't'}, '<M-h>', [[<C-w>H]])
vim.keymap.set({'v', 'n', 'i', 't'}, '<M-j>', [[<C-w>J]])
vim.keymap.set({'v', 'n', 'i', 't'}, '<M-k>', [[<C-w>K]])
vim.keymap.set({'v', 'n', 'i', 't'}, '<M-l>', [[<C-w>L]])
vim.keymap.set({'v', 'n', 'i', 't'}, '<M-w>', [[<C-w>w]])
vim.keymap.set({'v', 'n', 'i', 't'}, '<M-r>', [[<C-w>r]])
vim.keymap.set({'v', 'n', 'i', 't'}, '<M-x>', [[<C-w>x]])
vim.keymap.set({'v', 'n', 'i', 't'}, '<M-s>', [[<C-w>s]])
vim.keymap.set({'v', 'n', 'i', 't'}, '<M-v>', [[<C-w>v]])
vim.keymap.set({'v', 'n', 'i', 't'}, '<M-=>', [[<C-w>+]])
vim.keymap.set({'v', 'n', 'i', 't'}, '<M-->', [[<C-w>-]])
vim.keymap.set({'v', 'n', 'i', 't'}, '<M-,>', [[<C-w><Lt>]])
vim.keymap.set({'v', 'n', 'i', 't'}, '<M-.>', [[<C-w>>]])
vim.keymap.set({'v', 'n', 'i', 't'}, '<C-q>', [[<C-w>q]])
vim.keymap.set({'v', 'n', 'i', 't'}, '<M-q>', [[<C-w>q]])
vim.keymap.set({'n'}, '<Esc>', [[<Cmd>nohls<CR><Esc>]], { noremap = true })
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]])
-- vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)

-- vim.keymap.set('i', '<M-]>', [[<Plug>(copilot-next)]])
-- vim.keymap.set('i', '<M-[>', [[<Plug>(copilot-previous)]])
-- vim.keymap.set('i', '<M-/>', [[<Plug>(copilot-suggest)]])

-- local _gpt_add_key_map_timer = vim.loop.new_timer()
-- _gpt_add_key_map_timer:start(100, 100, vim.schedule_wrap(function ()
--     if _gpt_add_key_map_timer and pcall(function () vim.cmd [[GPTSuggestedKeymaps]] end) then
--         _gpt_add_key_map_timer:stop()
--         _gpt_add_key_map_timer = nil
--     end
-- end))

return map

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
map({"v", "n"}, "gm", "gM", { noremap = true })
map({"v", "n"}, "gM", "gm", { noremap = true })
map({"v", "n", "i"}, "<F4>", "<cmd>wa<CR>")
map({"v", "n", "i", "t"}, "<F7>", "<cmd>NvimTreeFindFileToggle<CR>", { silent = true })
map({"v", "n", "i", "t"}, "<F9>", "<cmd>TroubleToggle<CR>", { silent = true })
-- map({"v", "n", "i", "t"}, "<F19>", "<cmd>TroubleToggle<CR>")
local found_cmake, cmake = pcall(require, "cmake-tools")
if found_cmake then
    map({"v", "n", "i", "t"}, "<F5>", "<cmd>wa<CR><cmd>if luaeval('require\"cmake-tools\".is_cmake_project()')|call execute('CMakeRun')|else|call execute('TermExec cmd=!!')|endif<CR>", { silent = true })
    map({"v", "n", "i", "t"}, "<F17>", "<cmd>wa<CR><cmd>if luaeval('require\"cmake-tools\".is_cmake_project()')|call execute('CMakeStop')|else|call execute('TermExec cmd=\\<C-c>')|endif<CR>", { silent = true })
else
    map({"v", "n", "i", "t"}, "<F5>", "<cmd>wa<CR><cmd>call execute('TermExec cmd=!!<')CR>", { silent = true })
    map({"v", "n", "i", "t"}, "<F17>", "<cmd>wa<CR><cmd>call execute('TermExec cmd=\\<C-c>')<CR>", { silent = true })
end
-- map({"v", "n", "i", "t"}, "<F10>", "<cmd>DapToggleBreakpoint<CR>", { silent = true })
-- map({"v", "n", "i", "t"}, "<F22>", "<cmd>DapToggleRepl<CR>", { silent = true })
-- map({"v", "n", "i", "t"}, "<F12>", "<cmd>DapStepOver<CR>", { silent = true })
-- map({"v", "n", "i", "t"}, "<F24>", "<cmd>DapStepInto<CR>", { silent = true })
-- map({"v", "n", "i", "t"}, "<C-F12>", "<cmd>DapStepOut<CR>", { silent = true })
-- if found_cmake then
--     map({"v", "n", "i", "t"}, "<F9>", "<cmd>if luaeval('require\"cmake-tools\".is_cmake_project() and require\"dap\".session()==nil')|call execute('CMakeDebug')|else|call execute('DapContinue')|endif<CR>", { silent = true })
--     map({"v", "n", "i", "t"}, "<F21>", "<cmd>if luaeval('require\"cmake-tools\".is_cmake_project() and require\"dap\".session()==nil')|call execute('CMakeStop')|else|call execute('DapTerminate')|endif<CR>", { silent = true })
-- else
--     map({"v", "n", "i", "t"}, "<F9>", "<cmd>DapContinue<CR>", { silent = true })
--     map({"v", "n", "i", "t"}, "<F21>", "<cmd>DapTerminate<CR>", { silent = true })
-- end
vim.keymap.set({'v', 'n', 'i', 't'}, '<Ins>', [[<Cmd>ZenMode<CR>]])
-- map({"v", "n"}, "<CR>", "<cmd>nohlsearch<CR>", { silent = true })
map("i", "jk", "<Esc>", { silent = true })
map("i", "kj", "<Esc>", { silent = true })
map("t", "jk", "<C-\\><C-n>", { silent = true })
map("t", "kj", "<C-\\><C-n>", { silent = true })
map("n", "q", "<cmd>wa<CR><cmd>q<CR>", { silent = true })
map("v", "q", "<Esc>", { silent = true })
map("n", "Q", "q", { silent = true, noremap = true })
map({"v", "n"}, "g=", "<cmd>Neoformat<CR>", { silent = true })
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

-- vim.keymap.set('i', '<CR>', 'copilot#Accept("\\<CR>")', {
--     silent = true,
--     expr = true,
--     replace_keycodes = false,
-- })
-- vim.keymap.set('i', '<M-BS>', '<Plug>(copilot-dismiss)')
-- vim.keymap.set('i', '<M-\\>', '<Plug>(copilot-suggest)')
-- vim.keymap.set('i', '<M-[>', '<Plug>(copilot-previous)')
-- vim.keymap.set('i', '<M-]>', '<Plug>(copilot-next)')
-- vim.keymap.set('i', '<M-CR>', '<Plug>(copilot-accept-word)')
-- vim.g.copilot_no_tab_map = true

-- fetch
-- vim.keymap.set('i', '<F23>', '<Esc>vH0o"+y:let b:_f23="v"<CR>gi', { silent = true, nowait = true, noremap = true })
-- vim.keymap.set('t', '<F23>', '<C-\\><C-n>H"+yL:let b:_f23="v"<CR>i', { silent = true, nowait = true, noremap = true })
-- vim.keymap.set('n', '<F23>', 'mYH"+yL`Y:let b:_f23="V"<CR>', { silent = true, nowait = true, noremap = true })
-- vim.keymap.set('v', '<F23>', 'mY"+y`Y:let b:_f23=getregtype("+")<CR>gv', { silent = true, nowait = true, noremap = true })
--
-- -- append
-- vim.keymap.set('i', '<F24>', '<Esc>:cal setreg("+",getreg("+"),get(b:,"_f23","v"))|let b:_f23=""<CR>"+pa', { silent = true, nowait = true, noremap = true })
-- vim.keymap.set('t', '<F24>', '<C-e><C-\\><C-n>:cal setreg("+",getreg("+"),get(b:,"_f23","v"))|let b:_f23=""<CR>"+pi', { silent = true, nowait = true, noremap = true })
-- vim.keymap.set('n', '<F24>', ':cal setreg("+",getreg("+"),get(b:,"_f23","v"))|let b:_f23=""<CR>"+p', { silent = true, nowait = true, noremap = true })
-- vim.keymap.set('v', '<F24>', '<Esc>:cal setreg("+",getreg("+"),get(b:,"_f23","v"))|let b:_f23=""<CR>"+p', { silent = true, nowait = true, noremap = true })
--
-- -- prepend
-- vim.keymap.set('i', '<F47>', '<Esc>go:cal setreg("+",getreg("+"),"V")|let b:_f23=""<CR>"+Pgi', { silent = true, nowait = true, noremap = true })
-- vim.keymap.set('t', '<F47>', '<C-a><C-\\><C-n>:cal setreg("+",getreg("+"),get(b:,"_f23","v"))|let b:_f23=""<CR>"+pi<C-e>', { silent = true, nowait = true, noremap = true })
-- vim.keymap.set('n', '<F47>', 'mYgo:cal setreg("+",getreg("+"),"V")|let b:_f23=""<CR>"+P`Y', { silent = true, nowait = true, noremap = true })
-- vim.keymap.set('v', '<F47>', 'mYo<Esc>:cal setreg("+",getreg("+"),get(b:,"_f23","v"))|let b:_f23=""<CR>"+P`Y', { silent = true, nowait = true, noremap = true })
--
-- -- overwrite
-- vim.keymap.set('i', '<F48>', '<Esc>:cal setreg("+",getreg("+"),get(b:,"_f23","v"))|if get(b:,"_f23","")!=""|cal execute("norm!gv")|en|let b:_f23=""<CR>"+pa', { silent = true, nowait = true, noremap = true })
-- vim.keymap.set('t', '<F48>', '<C-u><C-\\><C-n>:cal setreg("+",getreg("+"),get(b:,"_f23","v"))|let b:_f23=""<CR>"+pi', { silent = true, nowait = true, noremap = true })
-- vim.keymap.set('n', '<F48>', ':cal setreg("+",getreg("+"),get(b:,"_f23","v"))|if get(b:,"_f23","")!=""|cal execute("norm!HVL")|en|let b:_f23=""<CR>"+pM', { silent = true, nowait = true, noremap = true })
-- vim.keymap.set('v', '<F48>', ':cal setreg("+",getreg("+"),get(b:,"_f23","v"))|let b:_f23=""<CR>"+p', { silent = true, nowait = true, noremap = true })
--
-- -- insert
-- vim.keymap.set('i', '<F46>', '<Esc>"+pa', { silent = true, nowait = true, noremap = true })
-- vim.keymap.set('t', '<F46>', '<C-\\><C-n>"+pi', { silent = true, nowait = true, noremap = true })
-- vim.keymap.set('n', '<F46>', '"+pa', { silent = true, nowait = true, noremap = true })
-- vim.keymap.set('v', '<F46>', '<Esc>"+pa', { silent = true, nowait = true, noremap = true })

-- vim.cmd [[
-- iabbr `` ``!cursor!<CR>```<Esc>:call search('!cursor!', 'b')<CR>cf!
-- ]]

vim.keymap.set({'v', 'n'}, 'K', function ()
    vim.lsp.buf.hover()
end)

vim.keymap.set({'v', 'n'}, 'ga', function ()
    vim.lsp.buf.code_action({
        apply = true,
    })
end)

vim.cmd [[
autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()
autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
]]

return map

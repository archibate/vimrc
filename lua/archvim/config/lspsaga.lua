-- https://github.com/tami5/lspsaga.nvim

require("lspsaga").setup {
    -- 提示边框样式：round、single、double
    border_style = "round",
    error_sign = " ",
    warn_sign = " ",
    hint_sign = " ",
    infor_sign = " ",
    diagnostic_header_icon = " ",
    -- 正在写入的行提示
    code_action_icon = " ",
    code_action_prompt = {
        -- 显示写入行提示
        -- 如果为 true ，则写代码时会在左侧行号栏中显示你所定义的图标
        enable = false,
        sign = true,
        sign_priority = 40,
        virtual_text = true,
    },
    -- 快捷键配置
    code_action_keys = {
        quit = "<Esc>",
        exec = "<CR>",
    },
    rename_action_keys = {
        quit = "<Esc>",
        exec = "<CR>",
    },
}

vim.cmd [[
" code action
nnoremap <silent> gA <cmd>lua require('lspsaga.codeaction').code_action()<CR>
vnoremap <silent> gA :<C-u>lua require('lspsaga.codeaction').range_code_action()<CR>

" rename, close rename win use <C-c> in insert mode or `q` in noremal mode or `:q`
nnoremap <silent> gR <cmd>lua require('lspsaga.rename').rename()<CR>

" preview definition
nnoremap <silent> gK <cmd>lua require('lspsaga.provider').preview_definition()<CR>

" show hover doc
nnoremap <silent> K <cmd>lua require('lspsaga.hover').render_hover_doc()<CR>
" scroll down hover doc or scroll in definition preview
nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>
" scroll up hover doc
nnoremap <silent> <C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>
" show signature help
nnoremap <silent> gsK <cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>

" show diagnostic on current line
nnoremap <silent> ga <cmd>lua require('lspsaga.diagnostic').show_line_diagnostics()<CR>

]]

-- Diagnostic jump
-- You can use <C-o> to jump back to your previous location
vim.keymap.set("n", "[a", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
vim.keymap.set("n", "]a", "<cmd>Lspsaga diagnostic_jump_next<CR>")
-- -- Diagnostic jump with filters such as only jumping to an error
-- vim.keymap.set("n", "[E", function()
--   require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
-- end)
-- vim.keymap.set("n", "]E", function()
--   require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
-- end)

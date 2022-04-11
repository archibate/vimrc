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
nnoremap <silent><leader>ca <cmd>lua require('lspsaga.codeaction').code_action()<CR>
vnoremap <silent><leader>ca :<C-u>lua require('lspsaga.codeaction').range_code_action()<CR>
]]

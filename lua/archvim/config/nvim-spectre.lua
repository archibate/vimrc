-- https://github.com/nvim-pack/nvim-spectre
-- WARN: spectre 手动安装依赖项 sed 和 ripgrep
-- sed 命令（自行安装，如果已有则忽略）
-- ripgrep: https://github.com/BurntSushi/ripgrep

require("spectre").setup {
    mapping = {
        -- 删除选中
        ["toggle_line"] = {
            map = "dd",
            cmd = "<cmd>lua require('spectre').toggle_line()<CR>",
            desc = "toggle current item"
        },
        -- 前往文件
        ["enter_file"] = {
            map = "<CR>",
            cmd = "<cmd>lua require('spectre.actions').select_entry()<CR>",
            desc = "goto current file"
        },
        -- 查看菜单（忽略大小写、忽略隐藏文件）
        ["show_option_menu"] = {
            map = "go",
            cmd = "<cmd>lua require('spectre').show_options()<CR>",
            desc = "show option"
        },
        -- 开始替换
        ["run_replace"] = {
            map = "gr",
            cmd = "<cmd>lua require('spectre.actions').run_replace()<CR>",
            desc = "replace all"
        },
        -- 显示差异
        ["change_view_mode"] = {
            map = "gv",
            cmd = "<cmd>lua require('spectre').change_view()<CR>",
            desc = "change result view mode"
        }
    }
}

local map = require'archvim/mappings'
-- 全项目替换
map("n", "<leader>sp", "<cmd>lua require('spectre').open()<CR>")
-- 只替换当前文件
map("n", "<leader>sf", "<cmd>lua require('spectre').open_file_search()<CR>")
-- 全项目中搜索当前单词
map("n", "<leader>sw", "<cmd>lua require('spectre').open_visual({select_word=true})<CR>")

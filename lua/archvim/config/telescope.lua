require("telescope").setup{}

local map = require'archvim/mappings'
-- 查找文件
map("n", "<leader>u", "<cmd>Telescope find_files theme=dropdown<CR>")
-- 查找 git 仓库中的文件
map("n", "<leader>i", "<cmd>Telescope git_files theme=dropdown<CR>")
-- 查找最近打开过的文件
map("n", "<leader>o", "<cmd>Telescope oldfiles theme=dropdown<CR>")
-- 查找 git status 中的文件
map("n", "<leader>p", "<cmd>Telescope git_status theme=dropdown<CR>")
-- 查找当前项目文件中的文字
map("n", "<leader>k", "<cmd>Telescope live_grep theme=dropdown<CR>")
-- 查找所有已打开文件
map("n", "<leader>l", "<cmd>Telescope buffers theme=dropdown<CR>")
-- 查找 vim 的跳转记录
map("n", "<leader>j", "<cmd>Telescope jumplist theme=dropdown<CR>")
-- 查找 vim 的标记
map("n", "<leader>m", "<cmd>Telescope marks theme=dropdown<CR>")
-- 查找 / 的搜索记录
map("n", "<leader>/", "<cmd>Telescope search_history theme=dropdown<CR>")
-- 查找 vim 命令历史记录
map("n", "<leader>:", "<cmd>Telescope command_history theme=dropdown<CR>")
-- 查找所有 vim 命令
map("n", "<leader>;", "<cmd>Telescope commands theme=dropdown<CR>")
-- 查找帮助文档
map("n", "<leader>?", "<cmd>Telescope help_tags theme=dropdown<CR>")
-- 查找 todo 等事项
map("n", "<leader>t", "<cmd>TodoTelescope theme=dropdown<CR>")
-- 查找 git 仓库的 commit 历史
map("n", "<leader>c", "<cmd>Telescope git_commits theme=dropdown<CR>")
-- 查找 git 仓库的所有分支
map("n", "<leader>C", "<cmd>Telescope git_branches theme=dropdown<CR>")
-- 查找本文件中所有静态分析报错
map("n", "<leader>a", "<cmd>Telescope diagnostics theme=dropdown<CR>")

-- 查找符号定义（LSP）
map("n", "gd", "<cmd>Telescope lsp_definitions theme=dropdown<CR>")
-- 查找所有引用（LSP）
map("n", "gr", "<cmd>Telescope lsp_references theme=dropdown<CR>")
-- 查找函数实现（LSP）
map("n", "gD", "<cmd>Telescope lsp_implementations theme=dropdown<CR>")

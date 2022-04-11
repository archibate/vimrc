require("telescope").setup{}

local map = require'archvim/mappings'
map("n", "<leader>f<space>", ":Telescope ")
-- 查找文件
map("n", "<leader>ff", "<cmd>Telescope find_files theme=dropdown<CR>")
-- 查找最近打开的文件
map("n", "<leader>fo", "<cmd>Telescope oldfiles theme=dropdown<CR>")
-- 查找 git 仓库中的文件
map("n", "<leader>fi", "<cmd>Telescope git_files theme=dropdown<CR>")
-- 查找 git status 中的文件
map("n", "<leader>fs", "<cmd>Telescope git_status theme=dropdown<CR>")
-- 查找 git 仓库的 commit 历史
map("n", "<leader>fc", "<cmd>Telescope git_commits theme=dropdown<CR>")
-- 查找 git 仓库的所有分支
map("n", "<leader>fC", "<cmd>Telescope git_branches theme=dropdown<CR>")
-- 查找本文件中所有静态分析报错
map("n", "<leader>fa", "<cmd>Telescope diagnostics theme=dropdown<CR>")
-- 查找文件中的文字
map("n", "<leader>fg", "<cmd>Telescope live_grep theme=dropdown<CR>")
-- 查找所有已打开文件
map("n", "<leader>fb", "<cmd>Telescope buffers theme=dropdown<CR>")
-- 查找 / 的搜索记录
map("n", "<leader>f/", "<cmd>Telescope search_history theme=dropdown<CR>")
-- 查找 vim 命令历史记录
map("n", "<leader>f:", "<cmd>Telescope command_history theme=dropdown<CR>")
-- 查找所有 vim 命令
map("n", "<leader>f;", "<cmd>Telescope commands theme=dropdown<CR>")
-- 查找 vim 的跳转记录
map("n", "<leader>fj", "<cmd>Telescope jumplist theme=dropdown<CR>")
-- 查找帮助文档
map("n", "<leader>f?", "<cmd>Telescope help_tags theme=dropdown<CR>")
-- 查找 vim 的标记
map("n", "<leader>fm", "<cmd>Telescope marks theme=dropdown<CR>")
-- 查找 todo 等事项
map("n", "<leader>ft", "<cmd>TodoTelescope theme=dropdown<CR>")

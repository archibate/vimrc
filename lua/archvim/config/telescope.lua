require("telescope").setup{}

local map = require'archvim/mappings'
-- 查找文件
map("n", "<leader>ff", "<cmd>Telescope find_files theme=dropdown<CR>")
-- 查找文字
map("n", "<leader>fg", "<cmd>Telescope live_grep theme=dropdown<CR>")
-- 查找特殊符号
map("n", "<leader>fb", "<cmd>Telescope buffers theme=dropdown<CR>")
-- 查找帮助文档
map("n", "<leader>fh", "<cmd>Telescope help_tags theme=dropdown<CR>")
-- 查找最近打开的文件
map("n", "<leader>fo", "<cmd>Telescope oldfiles theme=dropdown<CR>")
-- 查找 marks 标记
map("n", "<leader>fm", "<cmd>Telescope marks theme=dropdown<CR>")
-- 查找 todo 标记
map("n", "<leader>ft", "<cmd>TodoTelescope theme=dropdown<CR>")

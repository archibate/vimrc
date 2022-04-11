-- 1.自动对齐
vim.g.neoformat_basic_format_align = 1
-- 2.自动删除行尾空格
vim.g.neoformat_basic_format_trim = 1
-- 3.将制表符替换为空格
vim.g.neoformat_basic_format_retab = 1
-- 只提示错误消息
vim.g.neoformat_only_msg_on_error = 1

local map = require'archvim/mappings'
map("n", "<F12>", "<cmd>Neoformat<CR>")

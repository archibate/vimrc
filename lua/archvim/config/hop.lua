require("hop").setup()

local map = require'archvim/mappings'
map("n", "<Space>", "<cmd>nohls|HopChar1<CR>")
map("v", "<Space>", "<cmd>nohls|HopChar1<CR>")
map("n", "<C-Space>", "<cmd>nohls|HopAnywhereCurrentLine<CR>")
map("v", "<C-Space>", "<cmd>nohls|HopAnywhereCurrentLine<CR>")

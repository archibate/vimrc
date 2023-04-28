require("hop").setup()

local map = require'archvim/mappings'
map("n", "<Space>", "<cmd>HopChar1<CR>")
map("v", "<Space>", "<cmd>HopChar1<CR>")
map("n", "<C-Space>", "<cmd>HopAnywhereCurrentLine<CR>")
map("v", "<C-Space>", "<cmd>HopAnywhereCurrentLine<CR>")

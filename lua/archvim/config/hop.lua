require("hop").setup()

local map = require'archvim/mappings'
map({"n", "v"}, "<Space>", "<cmd>HopChar1<CR>")
map({"n", "v"}, "<CR>", "<cmd>HopWord<CR>")

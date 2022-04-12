require("hop").setup()

local map = require'archvim/mappings'
map("n", "<leader><leader>", "<cmd>HopChar1<CR>")
map("v", "<leader><leader>", "<cmd>HopChar1<CR>")

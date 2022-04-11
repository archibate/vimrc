require("hop").setup()

local map = require'archvim/mappings'
map("n", "<leader><leader>", "<cmd>HopChar1<CR>")
map("n", "<leader>.", "<cmd>HopAnywhereCurrentLine<CR>")
map("v", "<leader><leader>", "<cmd>HopChar1<CR>")
map("v", "<leader>.", "<cmd>HopAnywhereCurrentLine<CR>")

require'refactoring'.setup{}

vim.keymap.set({ "n", "x" }, "<leader>ref", function() require('refactoring').refactor('Extract Function') end)
vim.keymap.set({ "n", "x" }, "<leader>rff", function() require('refactoring').refactor('Extract Function To File') end)
-- Extract function supports only visual mode
vim.keymap.set({ "n", "x" }, "<leader>rev", function() require('refactoring').refactor('Extract Variable') end)
-- Extract variable supports only visual mode
vim.keymap.set({ "n", "x" }, "<leader>rif", function() require('refactoring').refactor('Inline Function') end)
-- Inline func supports only normal
vim.keymap.set({ "n", "x" }, "<leader>riv", function() require('refactoring').refactor('Inline Variable') end)
-- Inline var supports both normal and visual mode
vim.keymap.set({ "n", "x" }, "<leader>reb", function() require('refactoring').refactor('Extract Block') end)
vim.keymap.set({ "n", "x" }, "<leader>rfb", function() require('refactoring').refactor('Extract Block To File') end)
-- Extract block supports only normal mode
-- prompt for a refactor to apply when the remap is triggered
vim.keymap.set(
    {"n", "x"},
    "<leader>r?",
    function() require('refactoring').select_refactor() end
)
-- Note that not all refactor support both normal and visual mode

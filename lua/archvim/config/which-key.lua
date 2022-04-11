-- https://github.com/folke/which-key.nvim

require("which-key").setup {
    plugins = {
        marks = true, -- shows a list of your marks on ' and `
        registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        spelling = {
            -- 是否接管默认 z= 的行为
            enabled = true,
            suggestions = 24,
        },
    },
}

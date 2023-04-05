require'nvim-surround'.setup {
    keymaps = {
        insert = "<M-s>",
        insert_line = "<C-s>",
        normal = "ys",
        normal_cur = "yss",
        normal_line = "yS",
        normal_cur_line = "ySS",
        visual = "s",
        visual_line = "S",
        delete = "ds",
        change = "cs",
    },
}

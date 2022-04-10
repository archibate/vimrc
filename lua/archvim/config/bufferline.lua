require'bufferline'.setup {
    options = {
        diagnostics = "nvim_lsp",
        offsets = {{
            filetype = "NvimTree",
            text = "File Explorer",
            highlight = "Directory",
            text_align = "left",
        }},
        close_command = function(bufnum)
            require('bufdelete').bufdelete(bufnum, true)
        end,
    }
}

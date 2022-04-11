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

local map = require'archvim/mappings'
map("n", "<F2>", "<cmd>BufferLineCyclePrev<CR>", { silent = true })
map("n", "<F3>", "<cmd>BufferLineCycleNext<CR>", { silent = true })

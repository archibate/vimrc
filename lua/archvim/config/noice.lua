require("noice").setup {
    lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
        },
        signature = {
            enabled = true,
        },
    },
    presets = {
        bottom_search = false, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = true, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
    },
    cmdline = {
        enabled = true, -- enables the Noice cmdline UI
        view = "cmdline_popup", -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
        opts = {}, -- global options for the cmdline. See section on views
        format = {
            -- conceal: (default=true) This will hide the text in the cmdline that matches the pattern.
            -- view: (default is cmdline view)
            -- opts: any options passed to the view
            -- icon_hl_group: optional hl_group for the icon
            -- title: set to anything or empty string to hide
            cmdline = { pattern = "^:", icon = os.getenv('NERD_FONTS') and "" or ':', lang = "vim" },
            search_down = { kind = "search", pattern = "^/", icon = os.getenv('NERD_FONTS') and " " or '/', lang = "regex" },
            search_up = { kind = "search", pattern = "^%?", icon = os.getenv('NERD_FONTS') and " " or '?', lang = "regex" },
            filter = { pattern = "^:%s*!", icon = os.getenv('NERD_FONTS') and "" or '$', lang = "bash" },
            lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = os.getenv('NERD_FONTS') and "" or 'l', lang = "lua" },
            inc_rename = { pattern = { "^:%s*IncRename%s+" }, icon = os.getenv('NERD_FONTS') and "" or '>' },
            help = { pattern = "^:%s*he?l?p?%s+", icon = os.getenv('NERD_FONTS') and "" or 'h' },
            input = {}, -- Used by input()
            -- lua = false, -- to disable a format, set to `false`
        },
    },
}

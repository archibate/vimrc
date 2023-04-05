require'nvim-treesitter.configs'.setup {
    ensure_installed = {"c", "cpp", "python", "cmake", "lua", "rust", "help", "vim", "cuda", "bash", "vue", "markdown", "javascript", "typescript", "html", "css", "json", "yaml"},  -- INFO: add your language here
    sync_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = '+',
            node_incremental = '+',
            node_decremental = '-',
            -- scope_incremental = '+',
        }
    },
    indent = {
        enable = false,
    },
    rainbow = {
        enable = false,
        extended_mode = true,
    },
    context_commentstring = {
        enable = true,
    },
    textobjects = {
        select = {
            enable = true,

            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,

            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
                ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
                ["az"] = { query = "@fold", query_group = "locals", desc = "Select language fold" },
                ["ai"] = "@call.outer",
                ["ii"] = "@call.inner",
                ["ad"] = "@conditional.outer",
                ["id"] = "@conditional.inner",
                ["ao"] = "@loop.outer",
                ["io"] = "@loop.inner",
                ["ag"] = "@parameter.outer",
                ["ig"] = "@parameter.inner",
                ["aD"] = "@block.outer",
                ["iD"] = "@block.inner",
                ["aC"] = "@comment.outer",
                ["iC"] = "@comment.inner",
                ["ar"] = "@return.outer",
                ["ir"] = "@return.inner",
                ["al"] = "@statement.outer",
                ["il"] = "@statement.inner",
                ["an"] = "@number.outer",
                ["in"] = "@number.inner",
                ["ah"] = "@assignment.outer",
                ["ih"] = "@assignment.inner",
            },
            -- You can choose the select mode (default is charwise 'v')
            --
            -- Can also be a function which gets passed a table with the keys
            -- * query_string: eg '@function.inner'
            -- * method: eg 'v' or 'o'
            -- and should return the mode ('v', 'V', or '<c-v>') or a table
            -- mapping query_strings to modes.
            -- selection_modes = {
            --     ['@parameter.outer'] = 'v', -- charwise
            --     ['@function.outer'] = 'V', -- linewise
            --     ['@class.outer'] = '<c-v>', -- blockwise
            -- },
            -- If you set this to `true` (default is `false`) then any textobject is
            -- extended to include preceding or succeeding whitespace. Succeeding
            -- whitespace has priority in order to act similarly to eg the built-in
            -- `ap`.
            --
            -- Can also be a function which gets passed a table with the keys
            -- * query_string: eg '@function.inner'
            -- * selection_mode: eg 'v'
            -- and should return true of false
            include_surrounding_whitespace = false,
        },
        swap = {
            enable = true,
            swap_next = {
                ["gsl"] = "@parameter.inner",
            },
            swap_previous = {
                ["gsh"] = "@parameter.inner",
            },
        },
        move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
                ["]m"] = "@function.outer",
                ["]]"] = { query = "@class.outer", desc = "Next class start" },
                --
                -- You can use regex matching (i.e. lua pattern) and/or pass a list in a "query" key to group multiple queires.
                ["]o"] = "@loop.*",
                -- ["]o"] = { query = { "@loop.inner", "@loop.outer" } }
                --
                -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
                -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
                ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
                ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
            },
            goto_next_end = {
                ["]M"] = "@function.outer",
                ["]["] = "@class.outer",
                ["]O"] = "@loop.*",
                ["]S"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
                ["]Z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
            },
            goto_previous_start = {
                ["[m"] = "@function.outer",
                ["[["] = "@class.outer",
                ["[o"] = "@loop.*",
                ["[s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
                ["[z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
            },
            goto_previous_end = {
                ["[M"] = "@function.outer",
                ["[]"] = "@class.outer",
                ["[O"] = "@loop.*",
                ["[S"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
                ["[Z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
            },
            -- Below will go to either the start or the end, whichever is closer.
            -- Use if you want more granular movements
            -- Make it even more gradual by adding multiple queries and regex.
            goto_next = {
                ["]d"] = "@conditional.outer",
            },
            goto_previous = {
                ["[d"] = "@conditional.outer",
            }
        },
        lsp_interop = {
            enable = true,
            border = 'none',
            floating_preview_opts = {},
            peek_definition_code = {
                ["gsf"] = "@function.outer",
                ["gsc"] = "@class.outer",
            },
        },
    },
}
vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
vim.wo.foldlevel = 99

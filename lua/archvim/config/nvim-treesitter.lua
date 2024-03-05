-------------------------------
require'nvim-treesitter.configs'.setup {
    --ensure_installed = {"c", "cpp", "python", "cmake", "lua", "rust", "vim", "cuda", "glsl", "bash", "vue", "markdown", "javascript", "typescript", "html", "css", "json"},
    --sync_install = true,
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
        enable = true,
    },
    rainbow = {
        enable = false,
        extended_mode = true,
    },
    matchup = {
        enable = true,
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
                ["as"] = { query = "@scope", query_group = "locals" },
                ["az"] = { query = "@fold", query_group = "folds" },
                ["ai"] = "@call.outer",
                ["ii"] = "@call.inner",
                ["ad"] = "@conditional.outer",
                ["id"] = "@conditional.inner",
                ["ae"] = "@loop.outer",
                ["ie"] = "@loop.inner",
                ["ap"] = "@parameter.outer",
                ["ip"] = "@parameter.inner",
                ["ab"] = "@block.outer",
                ["ib"] = "@block.inner",
                ["at"] = "@comment.outer",
                ["it"] = "@comment.inner",
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
                ["]f"] = "@function.outer",
                ["]c"] = "@class.outer",
                ["]s"] = { query = "@scope", query_group = "locals" },
                ["]z"] = { query = "@fold", query_group = "folds" },
                ["]i"] = "@call.*",
                ["]d"] = "@conditional.*",
                ["]o"] = "@loop.*",
                ["]p"] = "@parameter.inner",
                ["]b"] = "@block.outer",
                ["]t"] = "@comment.*",
                ["]r"] = "@return.inner",
                ["]l"] = "@statement.*",
                ["]n"] = "@number.outer",
                ["]h"] = "@assignment.outer",
            },
            goto_next_end = {
                ["]F"] = "@function.outer",
                ["]C"] = "@class.outer",
                ["]S"] = { query = "@scope", query_group = "locals" },
                ["]Z"] = { query = "@fold", query_group = "folds" },
                ["]I"] = "@call.*",
                ["]D"] = "@conditional.*",
                ["]E"] = "@loop.*",
                ["]P"] = "@parameter.inner",
                ["]B"] = "@block.outer",
                ["]T"] = "@comment.*",
                ["]R"] = "@return.inner",
                ["]L"] = "@statement.*",
                ["]N"] = "@number.outer",
                ["]H"] = "@assignment.outer",
            },
            goto_previous_start = {
                ["[f"] = "@function.outer",
                ["[c"] = "@class.outer",
                ["[s"] = { query = "@scope", query_group = "locals" },
                ["[z"] = { query = "@fold", query_group = "folds" },
                ["[i"] = "@call.*",
                ["[d"] = "@conditional.*",
                ["[e"] = "@loop.*",
                ["[p"] = "@parameter.inner",
                ["[b"] = "@block.outer",
                ["[t"] = "@comment.*",
                ["[r"] = "@return.inner",
                ["[l"] = "@statement.*",
                ["[n"] = "@number.outer",
                ["[h"] = "@assignment.outer",
            },
            goto_previous_end = {
                ["[F"] = "@function.outer",
                ["[C"] = "@class.outer",
                ["[S"] = { query = "@scope", query_group = "locals" },
                ["[Z"] = { query = "@fold", query_group = "folds" },
                ["[I"] = "@call.*",
                ["[D"] = "@conditional.*",
                ["[E"] = "@loop.*",
                ["[P"] = "@parameter.*",
                ["[B"] = "@block.outer",
                ["[T"] = "@comment.*",
                ["[R"] = "@return.inner",
                ["[L"] = "@statement.*",
                ["[N"] = "@number.outer",
                ["[H"] = "@assignment.outer",
            },
            -- Below will go to either the start or the end, whichever is closer.
            -- Use if you want more granular movements
            -- Make it even more gradual by adding multiple queries and regex.
            -- goto_next = {
            --     ["]d"] = "@conditional.outer",
            -- },
            -- goto_previous = {
            --     ["[d"] = "@conditional.outer",
            -- }
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
    autotag = {
        enable = true,
    },
    -- refactor = {
    --     highlight_definitions = {
    --         enable = false,
    --         -- Set to false if you have an `updatetime` of ~100.
    --         clear_on_cursor_move = true,
    --     },
    --     highlight_current_scope = {
    --         enable = false,
    --     },
    --     smart_rename = {
    --         enable = true,
    --         -- Assign keymaps to false to disable them, e.g. `smart_rename = false`.
    --         keymaps = {
    --             smart_rename = "gnr",
    --         },
    --     },
    --     navigation = {
    --         enable = true,
    --         -- Assign keymaps to false to disable them, e.g. `goto_definition = false`.
    --         keymaps = {
    --             goto_definition = "gnd",
    --             list_definitions = "gnl",
    --             list_definitions_toc = "gno",
    --             goto_next_usage = "gn]",
    --             goto_previous_usage = "gn[",
    --         },
    --     },
    -- },
}

require('ts_context_commentstring').setup{}
vim.g.skip_ts_context_commentstring_module = true

vim.g.matchup_matchparen_offscreen = { method = "status" }
vim.g.matchup_surround_enabled = 1
vim.g.matchup_delim_noskips = 2

-- vim.wo.foldmethod = 'expr'
-- vim.wo.foldexpr = 'nvim_#foldexpr()'
-- vim.wo.foldlevel = 99

-- require'treesitter-context'.setup {
--   enable = false, -- Enable this plugin (Can be enabled/disabled later via commands)
--   max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
--   min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
--   line_numbers = true,
--   multiline_threshold = 20, -- Maximum number of lines to show for a single context
--   trim_scope = 'inner', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
--   mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
--   -- Separator between context and content. Should be a single character string, like '-'.
--   -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
--   separator = nil,
--   zindex = 20, -- The Z-index of the context window
--   on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
-- }

-- vim.keymap.set("n", "[.", function()
--   require("treesitter-context").go_to_context()
-- end, { silent = true })

-- use 'vm' to visual select any block like hop.nvim does
vim.cmd [[
omap     <silent> m :<C-U>lua pcall(require('tsht').nodes)<CR>
xnoremap <silent> m :lua pcall(require('tsht').nodes)<CR>
]]

-- require 'nt-cpp-tools'.setup {
--     preview = {
--         quit = 'q', -- optional keymapping for quit preview
--         accept = '<tab>' -- optional keymapping for accept preview
--     },
--     header_extension = 'hpp', -- optional
--     source_extension = 'cpp', -- optional
--     custom_define_class_function_commands = { -- optional
--         TSCppImplWrite = {
--             output_handle = require'nt-cpp-tools.output_handlers'.get_add_to_cpp()
--         }
--         --[[
--         <your impl function custom command name> = {
--             output_handle = function (str, context) 
--                 -- string contains the class implementation
--                 -- do whatever you want to do with it
--             end
--         }
--         ]]
--     }
-- }

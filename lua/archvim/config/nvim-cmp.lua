local lspkind = require('lspkind')
local cmp = require'cmp'

cmp.setup {
    -- view = 'custom',
    preselect = 'none',
    completion = {
        completeopt = 'menu,menuone,noinsert,noselect'
    },
    -- experimental = { ghost_text = true },

    -- 指定 snippet 引擎
    snippet = {
        expand = function(args)
            -- -- For `vsnip` users.
            -- vim.fn["vsnip#anonymous"](args.body)
    
            -- For `luasnip` users.
            require('luasnip').lsp_expand(args.body)
    
            -- For `ultisnips` users.
            -- vim.fn["UltiSnips#Anon"](args.body)
    
            -- For `snippy` users.
            -- require'snippy'.expand_snippet(args.body)
        end,
    },

    -- 来源
    sources = cmp.config.sources {
        {name = "nvim_lsp", max_item_count = 10},
        {name = "nvim_lsp_signature_help", max_item_count = 1},
        {name = "luasnip", max_item_count = 10},
        {name = "path"},
        -- {name = "codeium"}, -- INFO: uncomment this for AI completion
		{name = "cmp_yanky", max_item_count = 5},
        {name = "buffer", max_item_count = 8},
        {name = "rg", max_item_count = 5, keyword_length = 4},
        {name = "spell", max_item_count = 5},
        {name = "calc", max_item_count = 5},
        -- {name = "cmdline"},
        -- {name = "git"},
        {name = "emoji", max_item_count = 5},
        -- {name = "copilot"}, -- INFO: uncomment this for AI completion
        -- {name = "cmp_tabnine"}, -- INFO: uncomment this for AI completion
    },

    -- 对补全建议排序
    sorting = {
        comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.recently_used,
            require("cmp-under-comparator").under,
            -- require("cmp_tabnine.compare"), -- INFO: uncomment this for AI completion
            cmp.config.compare.kind,
            cmp.config.compare.length,
            cmp.config.compare.sort_text,
            cmp.config.compare.order,
        }
    },


    -- 快捷键
    mapping = {
        -- 上一个
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        -- 下一个
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif require("luasnip").expand_or_jumpable() then
                require("luasnip").expand_or_jump()
            -- elseif has_words_before() then
            --     cmp.complete()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif require("luasnip").jumpable(-1) then
                require("luasnip").jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
        -- 出现补全
        ['<C-j>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
        -- 取消
        ['<C-k>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        -- 确认
        -- Accept currently selected item. If none selected, `select` first item.
        -- Set `select` to `false` to only confirm explicitly selected items.
        ['<CR>'] = cmp.mapping.confirm({
            select = false,
            behavior = cmp.ConfirmBehavior.Replace,
        }),
        -- ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
        ['<C-u>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
        ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    },

    -- 使用 lspkind-nvim 显示类型图标
    formatting = {
        format = os.getenv("NERD_FONTS") and lspkind.cmp_format {
            -- mode = 'symbol',
            with_text = false, -- do not show text alongside icons
            maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
            before = function (entry, vim_item)
                -- Source 显示提示来源
                -- vim_item.menu = "["..string.upper(entry.source.name).."]"
                before = function(entry, vim_item)
                    -- Custom icon for 'calc' source
                    if entry.source.name == "calc" then
                        vim_item.kind = ""
                        return vim_item
                    end

                    -- Custom icon for 'git' source
                    if entry.source.name == "git" then
                        vim_item.kind = ""
                        return vim_item
                    end

                    -- Custom icon for 'search' source
                    if entry.source.name == "rg" then
                        vim_item.kind = ""
                        return vim_item
                    end

                    -- Tailwind colors
                    vim_item = require("tailwindcss-colorizer-cmp").formatter(entry, vim_item)
                    return vim_item
                end
                return vim_item
            end,
            -- ellipsis_char = '...',
            -- symbol_map = { Codeium = "", },
        } or nil,
    },
}

-- Use buffer source for `/`.
-- cmp.setup.cmdline({'/', '?'}, {
--     mapping = cmp.mapping.preset.cmdline({
--         -- Use default nvim history scrolling
--         ["<C-n>"] = {
--             c = false,
--         },
--         ["<C-p>"] = {
--             c = false,
--         },
--         ['<S-Tab>'] = cmp.mapping.select_prev_item(),
--         ['<Tab>'] = cmp.mapping.select_next_item(),
--     }),
--     sources = {
--         { name = 'buffer' },
--     }
-- })
--
-- -- -- Use cmdline & path source for ':'.
-- cmp.setup.cmdline(':', {
--     mapping = cmp.mapping.preset.cmdline({
--         -- Use default nvim history scrolling
--         ["<C-n>"] = {
--             c = false,
--         },
--         ["<C-p>"] = {
--             c = false,
--         },
--         ['<S-Tab>'] = cmp.mapping.select_prev_item(),
--         ['<Tab>'] = cmp.mapping.select_next_item(),
--     }),
--     sources = cmp.config.sources {
--         { name = 'path' },
--         { name = 'cmdline' },
--     }
-- })

-- vim.opt.spell = true
-- vim.opt.spelllang = { 'en_us' }

require("tailwindcss-colorizer-cmp").setup({
    color_square_width = 2,
})

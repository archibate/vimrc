local plugins = {
    -- plugin utilities
    'wbthomason/packer.nvim',
    "nvim-lua/popup.nvim",
    "nvim-lua/plenary.nvim",
    {
        "rcarriga/nvim-notify",
        config = function() require'archvim/config/notify' end,
    },

    -- auto completions
    {
        'hrsh7th/nvim-cmp',
        requires = {
            -- {
            --     'yehuohan/cmp-im',
            --     'yehuohan/cmp-im-zh',
            -- },
            'onsails/lspkind-nvim',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'f3fora/cmp-spell',
            'hrsh7th/cmp-calc',
            "lukas-reineke/cmp-under-comparator",
            -- 'hrsh7th/cmp-copilot', -- INFO: uncomment this for AI completion
            -- {"tzachar/cmp-tabnine", run = "./install.sh"}, -- INFO: uncomment this for AI completion
            'saadparwaiz1/cmp_luasnip',
            {
                'L3MON4D3/LuaSnip',
                run = 'make install_jsregexp || true',
                requires = {
                    'rafamadriz/friendly-snippets',
                },
                config = function() require'archvim/config/luasnip' end,
            },
        },
        config = function() require'archvim/config/nvim-cmp' end,
    },

    -- lsp syntax diagnostics
    {
        'williamboman/mason.nvim',
        requires = {
            'williamboman/mason-lspconfig.nvim',
            "mason-org/mason-registry",
        },
        run = ":MasonUpdate",
        config = function() require'archvim/config/mason' end,
    },
    {
        'neovim/nvim-lspconfig',
        config = function() require'archvim/config/lspconfig' end,
    },
    {
        "tami5/lspsaga.nvim",
        config = function() require'archvim/config/lspsaga' end,
    },

    -- code refactoring
    -- {
    --     'LucHermitte/vim-refactor',
    --     requires = {
    --         'LucHermitte/lh-vim-lib',
    --         'LucHermitte/lh-tags',
    --         'LucHermitte/lh-dev',
    --         'LucHermitte/lh-style',
    --         'LucHermitte/lh-brackets',
    --     },
    -- },
    -- {
    --     "ThePrimeagen/refactoring.nvim",
    --     requires = {
    --         {"nvim-lua/plenary.nvim"},
    --         {"nvim-treesitter/nvim-treesitter"},
    --     },
    --     config = function() require'archvim/config/refactoring' end,
    -- },

    -- lint and error signs
    {
        "folke/trouble.nvim",
        requires = "nvim-tree/nvim-web-devicons",
        config = function() require("trouble").setup{} end,
    },
    {
        'kevinhwang91/nvim-bqf',
        ft = 'qf',
        config = function() require('bqf').setup{} end,
        requires = {
            {'junegunn/fzf', run = function() vim.fn['fzf#install']() end},
        },
    },
    -- {   -- uncomment to enable cpplint
    --     'mfussenegger/nvim-lint',
    --     config = function() require"archvim/config/nvim-lint" end,
    -- },
    -- {
    --     "petertriho/nvim-scrollbar",
    --     config = function() require"scrollbar".setup{} end,
    -- },

    -- zen-mode
    "folke/zen-mode.nvim",
    {
        "folke/twilight.nvim",
        config = function() require"archvim/config/twilight" end,
    },

    -- dap and debuggers
    -- {
    --     'folke/neodev.nvim',
    --     config = function() require'archvim/config/neodev' end,
    -- },
    -- {
    --     'rcarriga/nvim-dap-ui',
    --     requires = {
    --         'mfussenegger/nvim-dap',
    --         'theHamsta/nvim-dap-virtual-text',
    --     },
    --     config = function() require"archvim/config/nvim-dap" end,
    -- },
    -- {
    --     'cpiger/NeoDebug',
    --     config = function() end,
    -- },

    -- semantic highlighting and textobjects
    {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            require('nvim-treesitter.install').update({ with_sync = true })
        end,
        config = function() require'archvim/config/nvim-treesitter' end,
        requires = {
            'p00f/nvim-ts-rainbow',
            'nvim-treesitter/nvim-treesitter-textobjects',
            -- 'nvim-treesitter/nvim-treesitter-context',
            'JoosepAlviste/nvim-ts-context-commentstring',
            'windwp/nvim-ts-autotag',
            'andymass/vim-matchup',
            'mfussenegger/nvim-treehopper',
        },
    },
    -- {
    --     -- "romgrk/nvim-treesitter-context",
    --     "SmiteshP/nvim-navic",
    --     requires = 'nvim-treesitter/nvim-treesitter',
    -- },

    -- color and themes
    {
        'ellisonleao/gruvbox.nvim',
        requires = 'rktjmp/lush.nvim',
    },
    -- {
    --     'AlphaTechnolog/pywal.nvim',
    --     as = 'pywal',
    -- },
    'glepnir/zephyr-nvim',
    'shaunsingh/nord.nvim',
    'tikhomirov/vim-glsl',

    -- git support
    {
        'lewis6991/gitsigns.nvim',
        config = function() require'archvim/config/gitsigns' end,
    },
    -- 'tpope/vim-fugitive',
    {
        "NeogitOrg/neogit",
        requires = {
            "nvim-lua/plenary.nvim",         -- required
            "nvim-telescope/telescope.nvim", -- optional
            "sindrets/diffview.nvim",        -- optional
            "ibhagwan/fzf-lua",              -- optional
        },
        config = function() require'neogit'.setup{} end,
    },

    -- status line
    {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true },
        config = function() require'archvim/config/lualine' end,
    },
    'archibate/lualine-time',
    'archibate/lualine-lsp-progress',

    -- brace pairing
    -- {
    --     "ur4ltz/surround.nvim",
    --     config = function() require 'archvim/config/surround' end,
    -- },
    {
        'kylechui/nvim-surround',
        config = function() require 'archvim/config/nvim-surround' end,
    },
    -- {
    --     'm4xshen/autoclose.nvim',
    --     config = function() require 'archvim/config/autoclose' end,
    -- },
    -- {
    --     'windwp/nvim-autopairs',
    --     config = function() require'archvim/config/nvim-autopairs' end,
    -- },
    -- "terryma/vim-expand-region",

    -- code actions
    {
        "sbdchd/neoformat",
        config = function() require"archvim/config/neoformat" end,
    },
	{
        "terrortylor/nvim-comment",
        config = function() require'archvim/config/nvim-comment' end,
	},

    -- session and projects
    {
        "Shatur/neovim-session-manager",
        requires = "nvim-lua/plenary.nvim",
        config = function() require'archvim/config/neovim-session-manager' end,
    },
    -- {
    --     "startup-nvim/startup.nvim",
    --     requires = {"nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim"},
    --     config = function()
    --         require"startup".setup()
    --     end,
    -- },
    {
        "ethanholz/nvim-lastplace",
        config = function() require'nvim-lastplace'.setup{} end,
    },
    -- 'djoshea/vim-autoread',
    -- {
    --     "rmagatti/auto-session",
    --     config = function() require'archvim/config/auto-session' end,
    -- },
    --{ -- this performance stucks, so i disable it
        --"mbbill/undotree",
        --config = function() require'archvim/config/undotree' end,
    --},
    -- {   -- uncomment to enable autosave
    --     'Pocco81/AutoSave.nvim',
    --     config = function() require'archvim/config/autosave' end,
    -- },

    -- fuzzy searching
    {
        "nvim-telescope/telescope.nvim",
        requires = {
            "nvim-lua/plenary.nvim",
            "BurntSushi/ripgrep",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                run = "make || true",
            },
            {
                "nvim-telescope/telescope-frecency.nvim",
                requires = {"tami5/sqlite.lua"},   -- need to install sqlite lib
            },
            "nvim-telescope/telescope-ui-select.nvim",
            'LinArcX/telescope-changes.nvim',
            'nvim-telescope/telescope-github.nvim',
            -- "nvim-telescope/telescope-live-grep-raw.nvim",
        },
        config = function() require"archvim/config/telescope" end,
    },
    -- {
    --     "nvim-pack/nvim-spectre",
    --     requires = {
    --         "nvim-lua/plenary.nvim",
    --         "BurntSushi/ripgrep",
    --     },
    --     config = function() require"archvim/config/nvim-spectre" end,
    -- },
    {
        "folke/todo-comments.nvim",
        config = function() require"todo-comments".setup{} end
    },

    -- buffer and files
    {
        'akinsho/bufferline.nvim',
        tag = '*',
        requires = {
            'nvim-tree/nvim-web-devicons',
            'famiu/bufdelete.nvim',
        },
        config = function() require'archvim/config/bufferline' end,
    },
    {
        'kyazdani42/nvim-tree.lua',
        requires = 'nvim-tree/nvim-web-devicons',
        config = function() require'archvim/config/nvim-tree' end,
    },

    -- terminal and tasks
    {
        'akinsho/toggleterm.nvim',
        config = function() require'archvim/config/toggleterm' end,
    },
    {
        'Civitasv/cmake-tools.nvim',
        requires = "nvim-lua/plenary.nvim",
        config = function() require'archvim/config/cmake-tools' end,
    },
    -- {
    --     "Mythos-404/xmake.nvim",
    --     requires = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    --     config = function() require'xmake'.setup{} end,
    --     branch = 'v1',
    -- },
    -- {
    --     'stevearc/overseer.nvim',
    --     config = function() require'archvim/config/overseer' end,
    -- },
    -- {
    --     'skywind3000/asynctasks.vim',
    --     requires = {'skywind3000/asyncrun.vim', 'voldikss/vim-floaterm'},
    --     config = function() require'archvim/config/asynctasks' end,
    -- },

    -- cursor motion
    {
        "folke/which-key.nvim",
        config = function() require"archvim/config/which-key" end,
    },
    {
        "phaazon/hop.nvim",
        config = function() require"archvim/config/hop" end,
    },
    {
        "MunifTanjim/nui.nvim",
    },
    -- {
    --     "arnamak/stay-centered.nvim",
    --     config = function() require"stay-centered" end,
    -- },
    -- {'mg979/vim-visual-multi'},
    -- {
    --     "RRethy/vim-illuminate",
    --     config = function()
    --         vim.g.Illuminate_ftblacklist = {
    --             "NvimTree",
    --             "vista_kind",
    --             "toggleterm",
    --             "lsp-installer",
    --         }
    --     end,
    -- },

    -- neo-pioneering
    -- {
    --     os.getenv('ARCHIBATE_COMPUTER') and '/home/bate/Codes/nvim-gpt' or 'archibate/nvim-gpt',
    --     requires = { 'nvim-telescope/telescope.nvim' },
    --     config = function() require"archvim/config/nvim-gpt" end,
    -- },
    {
        os.getenv('ARCHIBATE_COMPUTER') and '/home/bate/Codes/genius.nvim' or 'archibate/genius.nvim',
        requires = {
            'nvim-lua/plenary.nvim',
            'MunifTanjim/nui.nvim',
        },
        config = function() require"archvim/config/genius" end,
    },
    -- 'Exafunction/codeium.vim',
    -- {
    --     "Exafunction/codeium.nvim",
    --     requires = {
    --         "nvim-lua/plenary.nvim",
    --         "hrsh7th/nvim-cmp",
    --     },
    --     config = function()
    --         require"codeium".setup{}
    --     end,
    -- },

    -- markdown editing
    -- {
    --     'iamcco/markdown-preview.nvim',
    --     run = function() vim.fn["mkdp#util#install"]() end,
    --     setup = function() vim.g.mkdp_filetypes = { "markdown" } end,
    --     config = function() vim.cmd [[let g:mkdp_browser = '/usr/bin/chromium']] end,
    --     ft = { "markdown" },
    --     requires = 'iamcco/mathjax-support-for-mkdp',
    -- },
    {
        'mzlogin/vim-markdown-toc',
        ft = { "markdown" },
    },
    -- {
    --     'plasticboy/vim-markdown',
    --     requires = 'godlygeek/tabular',
    --     config = function() vim.cmd [[let g:vim_markdown_math = 1]] end,
    --     ft = { "markdown" },
    -- },
    {
        'ferrine/md-img-paste.vim',
        config = function() vim.cmd [[
let g:mdip_imgdir = 'img' " save image in ./img
let g:mdip_imgname = 'image'
autocmd FileType markdown nnoremap <silent> gsp :call mdip#MarkdownClipboardImage()<CR>
        ]] end,
        ft = { "markdown" },
    },

    -- pinyin input method
    -- {
    --     'ZSaberLv0/ZFVimIM',
    --     requires = {
    --         'ZSaberLv0/ZFVimJob',
    --         -- 'ZSaberLv0/ZFVimGitUtil',
    --         'ZSaberLv0/ZFVimIM_openapi',
    --         'ZSaberLv0/ZFVimIM_pinyin_huge',
    --     },
    --     config = function() require'archvim/config/zfvimim' end,
    -- },

    -- neovim profiling and debugging
    -- 'dstein64/vim-startuptime',
}

----- {{{ BEGIN_CIHOU_PREDOWNLOAD
local archvim_predownload = vim.g.archvim_predownload
if archvim_predownload and archvim_predownload ~= 0 then
    local predownload
    if archvim_predownload == 2 then
        local thisdir = assert(vim.g.archvim_predownload_cachedir)
        assert(os.execute(string.format('mkdir -p %s/predownload', thisdir)))
        function predownload(repo)
            local path = string.format('%s/predownload/%s', thisdir, repo)
            if os.execute(string.format('test -d %s', path)) ~= 0 then
                assert(os.execute(string.format('git clone https://github.com/%s.git %s --depth=1', repo, path)) == 0, repo)
                -- vim.fn.system({'git', 'clone', string.format("https://github.com/%s.git %s", repo, path), '--depth=1'})
                os.execute(string.format('rm -rf %s/.git', path))
                -- vim.gg = path .. " downloaded"
            end
            return repo
        end
    else
        local thisdir = debug.getinfo(1).source:sub(2):match("(.*)/")
        function predownload(repo)
            -- if repo == 'wbthomason/packer.nvim' then
            --     return vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
            -- end
            local path = string.format('%s/predownload/%s', thisdir, repo)
            return path
        end
    end
    ---@generic T: table|string|number|boolean
    ---@param orig T
    ---@return T
    local function deepcopy(orig)
        local copy
        if type(orig) == 'table' then
            copy = {}
            for orig_key, orig_value in next, orig, nil do
                copy[deepcopy(orig_key)] = deepcopy(orig_value)
            end
            setmetatable(copy, deepcopy(getmetatable(orig)))
        else -- number, string, boolean, etc
            copy = orig
        end
        return copy
    end
    ---@generic T: table|string
    ---@param item T
    ---@return T
    local function recursivedownload(item)
        item = deepcopy(item)
        if type(item) == 'string' then
            item = predownload(item)
        elseif type(item) == 'table' then
            for index, subitem in ipairs(item) do
                item[index] = recursivedownload(subitem)
            end
            if item['requires'] then
                item['requires'] = recursivedownload(item['requires'])
            end
        end
        return item
    end
    plugins = recursivedownload(plugins)
    -- for k, v in pairs(plugins) do
    --     print(k, v)
    -- end
    -- debug.debug()
    -- if archvim_predownload == 2 then
    --     vim.cmd [[qa!]]
    --     os.exit()
    -- end
end
----- }}} END_CIHOU_PREDOWNLOAD

local function ensure_packer()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.isdirectory(install_path) == 0 then
        if archvim_predownload == 1 then
            local thisdir = debug.getinfo(1).source:sub(2):match("(.*)/")
            fn.system({'mkdir', '-p', install_path})
            fn.system({'rm', '-rf', install_path})
            local downloaded_path = string.format('%s/predownload/wbthomason/packer.nvim', thisdir)
            fn.system({'cp', '-r', downloaded_path, install_path})
        else
            fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        end
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end
local is_packer_bootstrap = ensure_packer()
local packer = require('packer')
packer.init({
    autoremove = true,
})
return packer.startup(function (use)
    for _, item in ipairs(plugins) do
        use(item)
    end
    if is_packer_bootstrap then
        -- if archvim_predownload == 1 then
        --     local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
        --     vim.fn.system({'rm', '-rf', install_path})
        -- end
        packer.sync()
    end
end)

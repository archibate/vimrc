vim.cmd [[packadd packer.nvim]]

local plugins = {
    -- plugin utilities
    'wbthomason/packer.nvim',
    "nvim-lua/popup.nvim",
    "nvim-lua/plenary.nvim",
    "rcarriga/nvim-notify",

    -- auto completions
    {
        'hrsh7th/nvim-cmp',
        requires = {
            'onsails/lspkind-nvim',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'f3fora/cmp-spell',
            "lukas-reineke/cmp-under-comparator",
            -- {"tzachar/cmp-tabnine", run = "./install.sh"}, -- INFO: uncomment this for AI completion
        },
        config = function() require'archvim/config/nvim-cmp' end,
    },
    {
        'hrsh7th/cmp-vsnip',
        requires = {
            'rafamadriz/friendly-snippets',
            'hrsh7th/vim-vsnip',
        },
    },

    -- lsp syntax diagnostics
    {
        'neovim/nvim-lspconfig',
        config = function() require'archvim/config/lspconfig' end,
    },
    'williamboman/nvim-lsp-installer',
    {
        "tami5/lspsaga.nvim",
        config = function() require'archvim/config/lspsaga' end,
    },
    {
        "sbdchd/neoformat",
        config = function() require"archvim/config/neoformat" end,
    },
    {
        "petertriho/nvim-scrollbar",
        config = function() require"scrollbar".setup{} end,
    },
    {
        'mfussenegger/nvim-lint',
        config = function() require"archvim/config/nvim-lint" end,
    },

    -- semantic highlighting
    {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function() require'archvim/config/nvim-treesitter' end,
        requires = 'p00f/nvim-ts-rainbow',
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        requires = 'nvim-treesitter/nvim-treesitter',
    },
    {
        "romgrk/nvim-treesitter-context",
        "SmiteshP/nvim-gps",
        requires = 'nvim-treesitter/nvim-treesitter',
    },
    'JoosepAlviste/nvim-ts-context-commentstring',

    -- color and themes
    {
        'ellisonleao/gruvbox.nvim',
        requires = 'rktjmp/lush.nvim',
    },
    'glepnir/zephyr-nvim',
    'shaunsingh/nord.nvim',

    -- git and status line
    {
        'lewis6991/gitsigns.nvim',
        config = function() require'archvim/config/gitsigns' end,
    },
    {
        'windwp/windline.nvim',
        config = function() require'archvim/config/windline' end,
    },
    'tpope/vim-fugitive',

    -- vim command tools
    {
        "ur4ltz/surround.nvim",
        config = function() require 'archvim/config/surround' end,
    },
    {
	    "terrortylor/nvim-comment",
        config = function() require 'archvim/config/nvim-comment' end,
	},
    "terryma/vim-expand-region",

    -- session and projects
    {
        "rmagatti/auto-session",
        config = function() require'archvim/config/auto-session' end,
    },
    {
        "ethanholz/nvim-lastplace",
        config = function() require'nvim-lastplace'.setup{} end,
    },
    {
        "mbbill/undotree",
        config = function() require'archvim/config/undotree' end,
    },

    -- fuzzy searching
    {
        "nvim-telescope/telescope.nvim",
        requires = {
            "nvim-lua/plenary.nvim",
            "BurntSushi/ripgrep",
        },
        config = function() require"archvim/config/telescope" end,
    },
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        run = "make",
    },
    {
        "nvim-telescope/telescope-frecency.nvim",
        requires = {"tami5/sqlite.lua"},   -- NOTE: need to install sqlite lib
    },
    "nvim-telescope/telescope-ui-select.nvim",
    "nvim-telescope/telescope-live-grep-raw.nvim",
    {
        "nvim-pack/nvim-spectre",
        requires = {
            "nvim-lua/plenary.nvim",
            "BurntSushi/ripgrep",
        },
        config = function() require"archvim/config/nvim-spectre" end,
    },
    {
        "folke/todo-comments.nvim",
        config = function() require"todo-comments".setup{} end
    },

    -- buffer and files
    {
        'akinsho/bufferline.nvim',
        tag = '*',
        requires = {
            'kyazdani42/nvim-web-devicons',
            'famiu/bufdelete.nvim',
        },
        config = function() require'archvim/config/bufferline' end,
    },
    {
        'kyazdani42/nvim-tree.lua',
        requires = 'kyazdani42/nvim-web-devicons',
        config = function() require'archvim/config/nvim-tree' end,
    },

    -- terminal and tasks
    {
        'akinsho/toggleterm.nvim',
        config = function() require'archvim/config/toggleterm' end,
    },
    {
        'skywind3000/asynctasks.vim',
        requires = {'skywind3000/asyncrun.vim', 'voldikss/vim-floaterm'},
        config = function() require'archvim/config/asynctasks' end,
    },

    -- miscellaneous
    {
        "folke/which-key.nvim",
        config = function() require"archvim/config/which-key" end,
    },
}

require'packer'.startup(function(use)
    for _, item in pairs(plugins) do
        use(item)
    end
    --for _, item in pairs(plugins) do
        --if item.config then
            --item.config()
        --end
    --end
end)

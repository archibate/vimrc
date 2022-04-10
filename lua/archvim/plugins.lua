vim.cmd [[packadd packer.nvim]]

local plugins = {
    -- plugin utilities
    'wbthomason/packer.nvim',
    "nvim-lua/popup.nvim",
    "nvim-lua/plenary.nvim",
    "rcarriga/nvim-notify",

    -- lsp and completions
    {
        'hrsh7th/nvim-cmp',
        requires = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            "saadparwaiz1/cmp_luasnip",
        },
        config = function() require'archvim/config/nvim-cmp' end,
    },
    {
        'rafamadriz/friendly-snippets',
        requires = {
            'hrsh7th/cmp-vsnip',
            'hrsh7th/vim-vsnip',
        },
    },
    {
        'neovim/nvim-lspconfig',
        'williamboman/nvim-lsp-installer',
        'onsails/lspkind-nvim',
        config = function() require'archvim/config/lspconfig' end,
    },

    -- syntax highlighting
    {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function() require'archvim/config/nvim-treesitter' end,
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

    -- quality-of-lifes
    {
        "ur4ltz/surround.nvim",
        config = function() require 'archvim/config/surround' end,
    },
    --{
        --"windwp/nvim-autopairs",
        --requires = 'hrsh7th/nvim-cmp',
        --config = function() require'archvim/config/autopairs' end,
    --},
    "terryma/vim-expand-region",
    "terrortylor/nvim-comment",

    -- session and projects
    {
        "rmagatti/auto-session",
        config = function() require'auto-session'.setup{} end,
    },
    {
        "ethanholz/nvim-lastplace",
        config = function() require'nvim-lastplace'.setup{} end,
    },

    -- fuzzy searching
    {
        "nvim-telescope/telescope.nvim",
        requires = { {'nvim-lua/plenary.nvim'} },
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

    -- colorschemes
    {
        'ellisonleao/gruvbox.nvim',
        requires = 'rktjmp/lush.nvim',
    },
    'glepnir/zephyr-nvim',
    'shaunsingh/nord.nvim',

    {
        'akinsho/toggleterm.nvim',
        config = function() require'archvim/config/toggleterm' end,
    },
    {
        'skywind3000/asynctasks.vim',
        requires = {'skywind3000/asyncrun.vim', 'voldikss/vim-floaterm'},
        config = function() require'archvim/config/asynctasks' end,
    },

    --'lewis6991/gitsigns.nvim',
    --{
        --'adelarsq/neoline.vim',
        --requires = 'lewis6991/gitsigns.nvim',
        --config = function() require'archvim/config/neoline' end,
    --},
}

require'packer'.startup(function(use)
    for _, item in pairs(plugins) do
        use(item)
    end
    for _, item in pairs(plugins) do
        if item.config then
            item.config()
        end
    end
end)

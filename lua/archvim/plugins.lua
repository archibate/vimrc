-- This file can be loaded by calling `lua require('plugins')` from your init.vim

vim.cmd [[packadd packer.nvim]]

local plugins = {
    'wbthomason/packer.nvim',

    -- nvim-cmp
    {
        'hrsh7th/nvim-cmp',
        requires = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
        },
        config = function() require'archvim/config/nvim-cmp' end,
    },
    -- vsnip
    {
        requires = {
            'hrsh7th/cmp-vsnip',
            'hrsh7th/vim-vsnip',
        },
        'rafamadriz/friendly-snippets',
    },
    -- lspkind
    'onsails/lspkind-nvim',
    {
        'neovim/nvim-lspconfig',
        'williamboman/nvim-lsp-installer',
        config = function() require'archvim/config/lspconfig' end,
    },
    {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function() require'archvim/config/nvim-treesitter' end,
    },

    {
        'akinsho/bufferline.nvim',
        tag = '*',
        requires = 'kyazdani42/nvim-web-devicons',
        config = function() require'archvim/config/bufferline' end,
    },
    {
        'kyazdani42/nvim-tree.lua',
        requires = 'kyazdani42/nvim-web-devicons',
    },

    {
        'ellisonleao/gruvbox.nvim',
        requires = 'rktjmp/lush.nvim',
    },
    'glepnir/zephyr-nvim',
    'shaunsingh/nord.nvim',

    'voldikss/vim-floaterm',
    {
        'skywind3000/asynctasks.vim',
        requires = {'skywind3000/asyncrun.vim', 'voldikss/vim-floaterm'},
        config = function() require'archvim/config/asynctasks' end,
    },

    'tpope/vim-fugitive',
    {
        'itchyny/lightline.vim',
        requires = 'tpope/vim-fugitive',
        config = function() require'archvim/config/lightline' end,
    },
}

require'packer'.startup(function(use)
    for _, item in pairs(plugins) do
        use(item)
        if item.config then
            item.config()
        end
    end
end)

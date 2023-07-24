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
        'neovim/nvim-lspconfig',
        config = function() require'archvim/config/lspconfig' end,
    },
    {
        "folke/trouble.nvim",
        requires = "nvim-tree/nvim-web-devicons",
        config = function() require("trouble").setup{} end,
    },
    -- 'williamboman/nvim-lsp-installer',
    {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        requires = "mason-org/mason-registry",
        -- run = ":MasonUpdate",
        config = function() require'archvim/config/mason' end,
    },
    {
        "tami5/lspsaga.nvim",
        config = function() require'archvim/config/lspsaga' end,
    },
    {
        "sbdchd/neoformat",
        config = function() require"archvim/config/neoformat" end,
    },
    -- {
    --     "petertriho/nvim-scrollbar",
    --     config = function() require"scrollbar".setup{} end,
    -- },
    {   -- INFO: uncomment to enable cpplint
        'mfussenegger/nvim-lint',
        config = function() require"archvim/config/nvim-lint" end,
    },

    -- semantic highlighting
    {
        'nvim-treesitter/nvim-treesitter',
        -- run = ':TSUpdate',
        config = function() require'archvim/config/nvim-treesitter' end,
        requires = 'p00f/nvim-ts-rainbow',
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        after = "nvim-treesitter",
        requires = 'nvim-treesitter/nvim-treesitter',
    },
    -- {
    --     -- "romgrk/nvim-treesitter-context",
    --     "SmiteshP/nvim-navic",
    --     requires = 'nvim-treesitter/nvim-treesitter',
    -- },
    'JoosepAlviste/nvim-ts-context-commentstring',

    -- color and themes
    {
        'ellisonleao/gruvbox.nvim',
        requires = 'rktjmp/lush.nvim',
    },
    'glepnir/zephyr-nvim',
    'shaunsingh/nord.nvim',
    'tikhomirov/vim-glsl',

    -- git and status line
    {
        'lewis6991/gitsigns.nvim',
        config = function() require'archvim/config/gitsigns' end,
    },
    -- {
    --     'windwp/windline.nvim',
    --     config = function() require'archvim/config/windline' end,
    -- },
    {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true },
        config = function() require'archvim/config/lualine' end,
    },
    'archibate/lualine-time',
    'tpope/vim-fugitive',

    -- vim command tools
    -- {
    --     "ur4ltz/surround.nvim",
    --     config = function() require 'archvim/config/surround' end,
    -- },
    {
        'kylechui/nvim-surround',
        config = function() require 'archvim/config/nvim-surround' end,
    },
    {
	    "terrortylor/nvim-comment",
        config = function() require 'archvim/config/nvim-comment' end,
	},
    -- "terryma/vim-expand-region",

    -- session and projects
    'djoshea/vim-autoread',
    {
        "rmagatti/auto-session",
        config = function() require'archvim/config/auto-session' end,
    },
    {
        "ethanholz/nvim-lastplace",
        config = function() require'nvim-lastplace'.setup{} end,
    },
    --{
        --"mbbill/undotree",
        --config = function() require'archvim/config/undotree' end,
    --},
    -- {   -- INFO: uncomment to enable autosave
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
    -- {
    --     'skywind3000/asynctasks.vim',
    --     requires = {'skywind3000/asyncrun.vim', 'voldikss/vim-floaterm'},
    --     config = function() require'archvim/config/asynctasks' end,
    -- },

    -- streaming keywords
    -- {  "jackMort/ChatGPT.nvim",
    --     config = function()
    --         require("chatgpt").setup({
    --             openai_params = {
    --                 model = "gpt-3.5-turbo",
    --                 frequency_penalty = 0,
    --                 presence_penalty = 0,
    --                 max_tokens = 300,
    --                 temperature = 0,
    --                 top_p = 1,
    --                 n = 1,
    --             },
    --             openai_edit_params = {
    --                 model = "gpt-3.5-turbo",
    --                 temperature = 0,
    --                 top_p = 1,
    --                 n = 1,
    --             },
    --         })
    --     end,
    --     requires = {
    --         "MunifTanjim/nui.nvim",
    --         "nvim-lua/plenary.nvim",
    --         "nvim-telescope/telescope.nvim",
    --     },
    -- },

    -- miscellaneous
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
    {
        'archibate/nvim-gpt',
        -- '/home/bate/Codes/nvim-gpt',
        requires = { 'nvim-telescope/telescope.nvim' },
        config = function() require"archvim/config/nvim-gpt" end,
    },
    -- {
    --     "arnamak/stay-centered.nvim",
    --     config = function() require"stay-centered" end,
    -- },
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
}

----- {{{ BEGIN_CIHOU_PREDOWNLOAD
local archvim_predownload = vim.g.archvim_predownload
if archvim_predownload and archvim_predownload ~= 0 then
    local predownload
    if archvim_predownload == 2 then
        local thisdir = '/tmp/archvim-build'
        assert(os.execute(string.format('mkdir -p %s/predownload', thisdir)))
        function predownload(repo)
            local path = string.format('%s/predownload/%s', thisdir, repo)
            if os.execute(string.format('test -d %s', path)) ~= 0 then
                assert(os.execute(string.format('git clone https://github.com/%s.git %s --depth=1', repo, path)) == 0)
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
    local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
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
local packer_bootstrap = ensure_packer()
require('packer').init {
    autoremove = true,
}
return require('packer').startup(function(use)
    for _, item in ipairs(plugins) do
        use(item)
    end
    if packer_bootstrap then
        -- if archvim_predownload == 1 then
        --     local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
        --     vim.fn.system({'rm', '-rf', install_path})
        -- end
        require('packer').sync()
    end
end)

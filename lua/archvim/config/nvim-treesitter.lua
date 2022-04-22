require'nvim-treesitter.configs'.setup {
  ensure_installed = {"c", "cpp", "python", "cmake"},  -- INFO: add your language here
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
      node_decremental = '_',
      scope_incremental = '-',
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
}
vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
vim.wo.foldlevel = 99

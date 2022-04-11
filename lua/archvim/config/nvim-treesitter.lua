require'nvim-treesitter.configs'.setup {
  ensure_installed = {"vim", "c", "cpp", "python"},  -- INFO: add your language here
  sync_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<CR>',
      node_incremental = '<CR>',
      node_decremental = '<BS>',
      scope_incremental = '<TAB>',
    }
  },
  indent = {
    enable = true,
  },
  rainbow = {
    enable = false,
    extended_mode = true,
  },
  context_commentstring = {
    enable = true
  },
}
vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
vim.wo.foldlevel = 99

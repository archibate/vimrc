local function lazy_load_snippets()
    require("luasnip.loaders.from_vscode").lazy_load()
end
vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = lazy_load_snippets })

-- vim.cmd [[
-- " press <C-E> to expand or jump in a snippet. These can also be mapped separately
-- " via <Plug>luasnip-expand-snippet and <Plug>luasnip-jump-next.
-- imap <silent><expr> <CR> luasnip#jumpable(1) ? '<Plug>luasnip-expand-or-jump' : '<CR>'
-- " -1 for jumping backwards.
-- inoremap <silent> <S-CR> <cmd>lua require('luasnip').jump(-1)<CR>
--
-- snoremap <silent> <CR> <cmd>lua require('luasnip').jump(1)<CR>
-- snoremap <silent> <S-CR> <cmd>lua require('luasnip').jump(-1)<CR>
--
-- "" For changing choices in choiceNodes (not strictly necessary for a basic setup).
-- "imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
-- "smap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
-- ]]

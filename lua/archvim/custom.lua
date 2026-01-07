if require'archvim.options'.more_cpp_ftdetect then
    vim.cmd [[
    augroup archvim_set_filetype
        au! BufRead,BufNewFile *.cppm,*.ixx setfiletype cpp
        au! BufRead,BufNewFile *.vert,*.frag,*.comp,*.geom,*.tess setfiletype glsl
    augroup end
    ]]
end
if require'archvim.options'.transparent_color then
    vim.cmd [[
    augroup colorscheme_mock
    " autocmd!
    " autocmd ColorScheme * hi Normal guibg=none | hi def link LspInlayHint Comment
        " \ | hi LspReferenceText guibg=none
        " \ | hi LspReferenceRead guibg=none
        " \ | hi LspReferenceWrite guibg=none
    " hi NormalFloat guifg=#928374 guibg=#282828 |
    " hi WinSeparator guibg=none |
    " hi TreesitterContext gui=NONE guibg=#282828 |
    " hi TreesitterContextBottom gui=underline guisp=Grey
    augroup END
    ]]
end

if not require'archvim.options'.enable_clipboard then
    vim.cmd [[
        set clipboard-=unnamedplus
    ]]
end

vim.cmd [[
" silent! colorscheme zephyr
" silent! colorscheme gruvbox
silent! colorscheme dawnfox
]]

-- More custom options goes here

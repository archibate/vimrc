vim.cmd [[
function! s:myLocalDb()
    let db = ZFVimIM_dbInit({
                \   'name' : 'LocalDb',
                \ })
    call ZFVimIM_cloudRegister({
                \   'mode' : 'local',
                \   'dbId' : db['dbId'],
                \   'repoPath' : '/home/bate/.ZFVimIM_localdb',
                \   'dbFile' : '/dbFile.txt',
                \   'dbCountFile' : '/dbCountFile.txt',
                \ })
endfunction
autocmd User ZFVimIM_event_OnDbInit call s:myLocalDb()
let g:ZFVimIM_cloudSync_enable = 0
]]

vim.cmd [[
let g:ZFVimIM_symbolMap = {
            \   ' ' : [''],
            \   '`' : ['·'],
            \   '!' : ['！'],
            \   '$' : ['￥'],
            \   '^' : ['……'],
            \   '-' : [''],
            \   '_' : ['——'],
            \   '(' : ['（'],
            \   ')' : ['）'],
            \   '[' : ['【'],
            \   ']' : ['】'],
            \   '<' : ['《'],
            \   '>' : ['》'],
            \   '\' : ['、'],
            \   '/' : ['、'],
            \   ';' : ['；'],
            \   ':' : ['：'],
            \   ',' : ['，'],
            \   '.' : ['。'],
            \   '?' : ['？'],
            \   "'" : ['‘', '’'],
            \   '"' : ['“', '”'],
            \   '0' : [''],
            \   '1' : [''],
            \   '2' : [''],
            \   '3' : [''],
            \   '4' : [''],
            \   '5' : [''],
            \   '6' : [''],
            \   '7' : [''],
            \   '8' : [''],
            \   '9' : [''],
            \ }
]]

vim.cmd [[
let g:ZFVimIM_keymap = 0

" nnoremap <expr><silent> ;; ZFVimIME_keymap_toggle_n()
inoremap <expr><silent> ;; ZFVimIME_keymap_toggle_i()
" vnoremap <expr><silent> ;; ZFVimIME_keymap_toggle_v()

" nnoremap <expr><silent> ;: ZFVimIME_keymap_next_n()
inoremap <expr><silent> ;: ZFVimIME_keymap_next_i()
" vnoremap <expr><silent> ;: ZFVimIME_keymap_next_v()

" nnoremap <expr><silent> ;, ZFVimIME_keymap_add_n()
inoremap <expr><silent> ;, ZFVimIME_keymap_add_i()
" xnoremap <expr><silent> ;, ZFVimIME_keymap_add_v()

" nnoremap <expr><silent> ;. ZFVimIME_keymap_remove_n()
inoremap <expr><silent> ;. ZFVimIME_keymap_remove_i()
" xnoremap <expr><silent> ;. ZFVimIME_keymap_remove_v()
]]

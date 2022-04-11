vim.cmd [[
"let g:floaterm_wintype = 'split'
"let g:floaterm_position = 'botright'
"let g:floaterm_height = 12
""
""let g:floaterm_keymap_new    = '<F1>'
""let g:floaterm_keymap_prev   = '<F2>'
""let g:floaterm_keymap_next   = '<F3>'
"let g:floaterm_keymap_toggle = '<C-t>'

let g:asyncrun_open = 6
let g:asynctasks_term_pos = 'toggleterm'
let g:asynctasks_term_rows = 6
let g:asynctasks_term_cols = 50
let g:asynctasks_term_reuse = 1
let g:asynctasks_term_focus = 0
let g:asyncrun_rootmarks = ['.tasks', '.git/']

function! AsyncTaskMultiple(first, ...)
    if len(a:000) >= 1
        if a:first == 0
            cclose
        endif
        let l:tmp = ""
        for task in a:000[1:]
            let l:tmp .= "'".l:task."',"
        endfor
        let l:tmp = l:tmp[:-1]
        let g:asyncrun_exit = "if g:asyncrun_code == 0 | call AsyncTaskMultiple(0, ".l:tmp.") | else | call AsyncTaskMultiple(0) | endif"
        exec "AsyncTask ".a:000[0]
    else
        let g:asyncrun_exit = ""
    endif
endfunction
command! -nargs=+ AsyncTasks   :call AsyncTaskMultiple(1, <f-args>)
]]

local map = require'archvim/mappings'
map("n", "<F5>", "<cmd>AsyncTasks project-build project-run<CR>")
map("n", "<F6>", "<cmd>AsyncTask project-build<CR>")
map("n", "<F7>", "<cmd>AsyncTasks file-build file-run<CR>")

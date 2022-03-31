"
" .vimrc used by a naive C++ coder: github.com/archibate
"
" I manage plugins using vim-plug (already bundled in my .vim folder):
" https://github.com/junegunn/vim-plug
"
" IMPORTANT: Simply put this .vimrc and .vim to your home folder won't work
" immediately. You need to run
"
" :PlugInstall
"
" when you launch Vim for the first time.
" This will initialize all the plugins, otherwise they will not shows up.
"
" Scroll to the end of this file to see my plugin list.
" Comment or uncomment some of them as you wish.
"
"
" Key maps
" --------
"
" Z    - equivalent to ZZ, exit vim (:wqa)
" Q    - equivalent to @@, repeat last macro
" H    - equivalent to ^, goto start of line
" L    - equivalent to $, goto end of line
" kj   - equivalent to <ESC>, exit insert mode
" z    - equivalent to zz, align cursor to center
"
" gt   - switch the next tab
" gT   - switch the prev tab
" ...
" <F2> - save and switch to prev tab
" <F3> - save and switch to next tab
" <F4> - save all opened files
"
" gci  - comment/uncomment selected code (visual mode)
" <F1> - switch between .h and .cpp files
"
" <F8>     - start shell in fullscreen (equivalent to :sh)
" <F9>     - toggle project file tree window (:NERDTreeToggle)
" <C-t>    - toggle built-in terminal in Vim
" <C-\>    - enter normal mode in terminal (to select text)
"
" <F5>     - build and run current CMake project
" <F6>     - build current CMake project, but don't run
" <F7>     - run current file as a single script (.c .cpp .py)
" <S-F7>   - configure current CMake project (via ccmake)
" <F10>    - toggle compile error window (equivalent to :QFix)
" <F12>    - search for required-from-here (useful for errors)
"
"
" Build and Run
" =============
"
" For build and run projects, I use the plugin 'asynctasks.vim'.
"
" By default <F5> will build the CMake project, and run the target named 'main'.
" This is defined in the '~/.vim/tasks.ini', which is bundled in my '.vim':
"
" [+]
" build_type=Release
" build_target=main
" build_dir=build
" build_generator=Ninja
" run_target=$(VIM:build_dir)/$(VIM:build_target)
" 
" [project-build]
" command=cmake -G "$(VIM:build_generator)" -B "$(VIM:build_dir)" -DCMAKE_EXPORT_COMPILE_COMMANDS:BOOL=ON -DCMAKE_BUILD_TYPE="$(VIM:build_type)" && cmake --build "$(VIM:build_dir)" --target "$(VIM:build_target)" --config "$(VIM:build_type)"
" output=(-type:terminal)
" cwd=$(VIM_ROOT)
"
" [project-run]
" command=$(VIM:run_target)
" output=quickfix
" cwd=$(VIM_ROOT)
"
" You can create a file named '.tasks' locally in the root of your project to
" override the default rules and variables, customized for your project, e.g.:
"
" [+]
" build_type=Debug
" build_target=zeno_pybind_module
" build_generator=Unix Makefiles
" run_target=python my_start_script.py
"
" May also use the :AsyncTaskEdit to create the '.tasks' file in project root.
" It will recognize the first directory containing '.tasks' or '.git' as root.
"
" See https://github.com/skywind3000/asynctasks.vim/blob/master/README-cn.md
"
"
" Auto completion
" ===============
"
" For auto-completion, I use the plugin 'coc.nvim', recommended by my students.
" Although 'coc.nvim' sounds like a NeoVim plugin, it works well in Vim too.
"
" IMPORTANT: Even after running :PlugInstall, auto-completion still won't work.
" You need the follow the below instructions carefully to set it up as well.
"
" To make 'coc.nvim' work at all, you need to first install Node.js:
"
" $ pacman -S nodejs          # Arch Linux
" $ apt install nodejs        # Ubuntu
" $ brew install -g node      # MacOS
" $ node --version            # check if installation succeed
"
"
" For C++ developers
" ------------------
"
" To make 'coc.nvim' work for C++, you need to install 'ccls'.
" First, run this command in Vim to enable 'ccls' in 'coc.nvim':
"
" :CocInstall coc-ccls
"
" Second, you need to install 'ccls' to your system.
" Arch Linux could install from their package manager:
"
" $ sudo pacman -S ccls
" $ ccls --version
"
" Ubuntu and MacOS could build ccls from source (tested on clang-13):
"
" $ git clone --depth=1 --recursive https://github.com/MaskRay/ccls.git
" $ cmake -B build -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_COMPILER=clang++
" $ cmake --build build --parallel 4
" $ sudo cmake --build build --target install
" $ ccls --version
"
" Now create a C++ file to test if auto-completion works, say:
"
" $ vim /tmp/test.cpp
"
" If it complains an error: 'extension "coc-ccls" doesn't contain main file'
" Don't worry, I meet this error too. Fix it by executing:
"
" $ cd ~/.config/coc/extensions/node_modules/coc-ccls/
" $ ln -s node_modules/ws/lib/ ./
"
" Now restart Vim and the error is gone, and another error occurs:
"
" [coc.nvim] Server languageserver.ccls failed to start: Error: invalid params
" of initialize: expected array for /workspaceFolders
"
" This means it doesn't find the 'compile_commands.json' of your project.
" This file contains information like compiler flags, include directories which
" are required by 'ccls' for providing auto-completion.
"
" If your project is CMake, simply set CMAKE_EXPORT_COMPILE_COMMANDS to ON:
"
" $ cd MyProject/
" $ cmake -B build -DCMAKE_EXPORT_COMPILE_COMMANDS:BOOL=ON
" $ vim MySourceFile.cpp
"
" CMake will automatically create the file 'build/compile_commands.json'.
" 'ccls' will recognize it. Now restart Vim, and auto-completion should work.
" If you use other build systems, search Bing: 'Bazel compile_commands.json'
"
" If you are using my <F5> key mapping to build your CMake project, then the
" '-DCMAKE_EXPORT_COMPILE_COMMANDS:BOOL=ON' is automatically added, no worry.
"
" Note that the build directory must be 'build', otherwise ccls won't find it.
"
" Also try run :CocConfig to open the ~/.vim/coc-settings.json file. This file
" is already bundled in my .vim folder, containing a C/C++ configuration.
"
"
" For Python developers
" ---------------------
"
" To make 'coc.nvim' work for Python, you need 'pyright'.
" First, run this command in Vim to enable 'pyright' in 'coc.nvim':
"
" :CocInstall coc-pyright
"
" For more details (e.g. work with Conda), see their official document:
" https://github.com/fannheyward/coc-pyright
"
" For other languages support of 'coc.nvim', see their official support list:
"
" https://github.com/neoclide/coc.nvim/wiki/Language-servers#ccobjective-c
"
"
" Key maps
" --------
"
" <tab> - trigger completion (in insert mode)
" gd - goto definition
" gD - goto declaration
" gr - goto references
" gy - goto type definition
" gi - goto implementation
" gf - format selected code (visual mode)
" gq - quick fix error on current line
" K - show documentation of symbol under cursor
"
"
" Fuzzy find
" ==========
"
" For fuzzy find, I use the plugin 'fzf.vim'. It's based on the Unix command
" line tools 'fzf', 'ag', and 'rg'. So make sure you have installed it first:
"
" $ pacman -S fzf                      # Arch Linux
" $ apt-get install fzf                # Ubuntu
" $ brew install fzf                   # MacOS
" $ fzf --version                      # check if installation succeed
"
" $ pacman -S the_silver_searcher      # Arch Linux
" $ apt-get install silversearcher-ag  # Ubuntu
" $ brew install the_silver_searcher   # MacOS
" $ ag --version                       # check if installation succeed
"
" $ pacman -S ripgrep                  # Arch Linux
" $ apt-get install ripgrep            # Ubuntu
" $ brew install ripgrep               # MacOS
" $ rg --version                       # check if installation succeed
"
" Hint: fzf could also be useful in command line, e.g.
"
" $ vim `fzf`
"
" To fuzzy find a file and open it in Vim.
"
"
" Key maps
" --------
"
" gof - fuzzy find file names in current direcory
" gob - fuzzy find file names in all opened files
" gog - fuzzy find file names in current git repo
" gos - fuzzy find file names from 'git status'
" goc - fuzzy find commits in current git repo
" gol - fuzzy find string in all opened files
" goo - fuzzy find string in the current file
" goh - fuzzy find recently opened files in history
" go: - fuzzy find runned ex-commands (:) in history
" go/ - fuzzy find searched strings (/) in history
" go? - fuzzy find vim ex-commands (including plugin commands)
" goa - invokes 'grep -r', recursively find string in files
" gor - like goa, but exclude files in .gitignore (e.g. build)
" g<tab> - fuzzy find key mappings
"

set hidden nocompatible
set encoding=utf-8
set et ts=4 sts=4 sw=4
set fdm=syntax fdl=100
set nu ru ls=2
set hls is si
set cinoptions=j1,(0,ws,Ws,g0
set timeout nottimeout
set tm=300 ttm=10
set mouse=a
set listchars=tab:▸\ ,trail:⋅,extends:❯,precedes:❮
set showbreak=↪
set list
"set noek
"set rulerformat=%55(%{strftime('%a\ %b\ %e\ %I:%M\ %p')}\ %5l,%-6(%c%V%)\ %P%)
set switchbuf=usetab
set undofile
if has('nvim')
    set undodir=/tmp/nvim//,.
    set backupdir=/tmp/nvim//,.
    set directory=/tmp/nvim//,.
else
    set undodir=/tmp//,.
    set backupdir=/tmp//,.
    set directory=/tmp//,.
endif
"set bg=dark


syntax on
filetype on
filetype plugin on
filetype indent on

"let g:mapleader = ' '
"let g:mapleader = ','
let g:mapleader = 'g'

nnoremap <silent> <F1> :wa<CR>:A<CR>
nnoremap <silent> <F2> :wa<CR>:bp<CR>
nnoremap <silent> <F3> :wa<CR>:bn<CR>
"nnoremap <silent> <S-F2> :wa<CR>:b#<CR>
nnoremap <silent> <F4> :wa<CR>
inoremap <silent> <F1> <ESC>
inoremap <silent> <F2> <ESC>:wa<CR>:bp<CR>
inoremap <silent> <F3> <ESC>:wa<CR>:bn<CR>
inoremap <silent> <F4> <ESC>:wa<CR>
inoremap <silent> <F8> <ESC>:wa<CR>:sh<CR><CR>
nnoremap <F5> :AsyncTasks project-build project-run<CR>
nnoremap <F6> :AsyncTask project-build<CR>
nnoremap <F7> :AsyncTasks file-build file-run<CR>
if has('nvim')
    nnoremap <F19> :AsyncTask project-config<CR>
else
    nnoremap <S-F7> :AsyncTask project-config<CR>
endif
nnoremap <silent> <F8> :wa<CR>:sh<CR><CR>
nnoremap <silent> <F9> :wa<CR>:NERDTreeToggle<CR><C-w>l
nnoremap <silent> <F10> :wa<CR>:QFix<CR>
inoremap <silent> <F10> <ESC>:wa<CR>:QFix<CR>
nnoremap <silent> <F12> /required from here<CR>
"nnoremap <silent> <C-k> <C-w>k:q<CR>
"nnoremap <silent> <C-j> <C-w>j
inoremap kj <ESC>
"inoremap <DEL> <ESC>
"nnoremap <DEL> <ESC>
"vnoremap <DEL> <ESC>

nnoremap Z ZZ
nnoremap Q ZQ
nnoremap H ^
nnoremap L $
"nnoremap z zz
vnoremap H ^
vnoremap L $
"vnoremap z zz
"nnoremap <CR> O<ESC>cc<ESC>j

nnoremap <silent> <C-t> :botright terminal<CR>
tnoremap <C-t> <C-w>q
tnoremap <C-\> <C-\><C-n>

" no longer used vimspector:
"nmap <S-F3> <Plug>VimspectorStop
"nmap <S-F4> <Plug>VimspectorRestart
"nmap <S-F5> <Plug>VimspectorContinue
"nmap <S-F6> <Plug>VimspectorPause
"nmap <S-F8> <Plug>VimspectorRunToCursor
"nmap <C-S-F8> <Plug>VimspectorAddFunctionBreakpoint
"nmap <S-F9> <Plug>VimspectorToggleBreakpoint
"nmap <C-S-F9> <Plug>VimspectorToggleConditionalBreakpoint
"nmap <S-F10> <Plug>VimspectorStepOver
"nmap <S-F11> <Plug>VimspectorStepInfo
"nmap <S-F12> <Plug>VimspectorStepOut
"nmap <LEADER>= <Plug>VimspectorBalloonEval
"xmap <LEADER>= <Plug>VimspectorBalloonEval
"let g:ycm_semantic_triggers = {'VimspectorPrompt': ['.', '->', ':', '<']}
"let g:cmake_vimspector_support = 1
"let g:cmake_vimspector_default_configuration = {
"\ 'adapter': 'vscode-cpptools',
"\ 'configuration': {
   "\ 'type': '',
   "\ 'request': 'launch',
   "\ 'cwd': '${workspaceRoot}',
   "\ 'Mimode': '',
   "\ 'args': [],
   "\ 'program': '',
   "\ "setupCommands": [
   "\ {
   "\ "description": "Enable pretty-printing for gdb",
   "\ "text": "-enable-pretty-printing",
   "\ "ignoreFailures": 'true',
   "\ }
   "\ ],
   "\ }
"\ }

" rid annoying swap prompts:
autocmd SwapExists * let v:swapchoice = "e"

" goto last location on open:
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" no longer used cmake4vim:
"let g:cmake_usr_args = '-GNinja'
"let g:cmake_build_target = 'main'
"let g:cmake_build_type = 'Release'
"let g:cmake_compile_commands = 1
"let g:cmake_build_path_pattern = ["%s/build", "getcwd()"]

" no longer used YouCompleteMe:
"let g:ycm_confirm_extra_conf = 0
"let g:ycm_error_symbol = '✗'
"let g:ycm_warning_symbol = '⚠'
"let g:ycm_filetype_whitelist = {"c": 1, "cpp": 1, "python": 1}
"let g:ycm_min_num_of_chars_for_completion = 2
"let g:ycm_show_diagnostics_ui = 1
"let g:ycm_key_invoke_completion = '<c-z>'
"let g:ycm_enable_diagnostic_signs = 0
"let g:ycm_enable_diagnostic_highlighting = 1
""let g:ycm_show_diagnostics_ui = 0
""let g:ycm_key_list_select_completion = ['<TAB>']
""let g:ycm_key_list_previous_completion = []

" no longer used ultisnips:
"let g:UltiSnipsExpandTrigger="<c-s>"
"let g:UltiSnipsJumpForwardTrigger="<tab>"
"let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
"let g:UltiSnipsEditSplit="vertical"

" for vim-cpp-modern:
let g:cpp_attributes_highlight = 1
"let g:cpp_member_highlight = 1

" for vim-airline:
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#buffer_nr_show = 0
let g:airline#extensions#tabline#formatter = 'default'
let g:airline#extensions#keymap#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
" 设置切换tab的快捷键 <\> + <i> 切换到第i个 tab
nmap <silent> <leader>1 <Plug>AirlineSelectTab1
nmap <silent> <leader>2 <Plug>AirlineSelectTab2
nmap <silent> <leader>3 <Plug>AirlineSelectTab3
nmap <silent> <leader>4 <Plug>AirlineSelectTab4
nmap <silent> <leader>5 <Plug>AirlineSelectTab5
nmap <silent> <leader>6 <Plug>AirlineSelectTab6
nmap <silent> <leader>7 <Plug>AirlineSelectTab7
nmap <silent> <leader>8 <Plug>AirlineSelectTab8
nmap <silent> <leader>9 <Plug>AirlineSelectTab9
"nmap <silent> <leader>1 :tab1<CR>
"nmap <silent> <leader>2 :tab2<CR>
"nmap <silent> <leader>3 :tab3<CR>
"nmap <silent> <leader>4 :tab4<CR>
"nmap <silent> <leader>5 :tab5<CR>
"nmap <silent> <leader>6 :tab6<CR>
"nmap <silent> <leader>7 :tab7<CR>
"nmap <silent> <leader>8 :tab8<CR>
"nmap <silent> <leader>9 :tab9<CR>
"cabbrev o tab drop
"cabbrev e tabe
"cabbrev m tabm
"cabbrev a tab ball
"autocmd BufReadPost * tab ball

" no longer used vim-terminal-help:

"let g:terminal_key = '<c-=>'
"let g:terminal_default_mapping = 1

"inoremap ÏF <ESC>A
"inoremap ÏH <ESC>I
"nnoremap ÏH ^
"nnoremap ÏF $
"vnoremap ÏH ^
"vnoremap ÏF $

" no longer used YouCompleteMe:
"nnoremap <LEADER><LEADER> :YcmCompleter GoTo<CR>
"nnoremap <LEADER>[ :YcmCompleter GoToDefinitionElseDeclaration<CR>
"nnoremap <LEADER>d :YcmCompleter GetDoc<CR>
"nnoremap <LEADER>r :YcmCompleter RefactorRename<SPACE>
"nnoremap <LEADER>f :YcmCompleter FixIt<CR>1
"nnoremap <LEADER>y :call ToggleYcmDiagnostics()<CR><CR>:wa<CR>:e<CR>
"func! ToggleYcmDiagnostics()
    "let g:ycm_show_diagnostics_ui = !g:ycm_show_diagnostics_ui
    "YcmRestartServer
"endfunc

" no longer used vim-ctrlspace:
"if has('nvim')
    "let g:CtrlSpaceDefaultMappingKey = "<C-space> "
"endif

"let g:CtrlSpaceLoadLastWorkspaceOnStart = 1
"let g:CtrlSpaceSaveWorkspaceOnSwitch = 1
"let g:CtrlSpaceSaveWorkspaceOnExit = 1
"if executable('rg')
    "let g:CtrlSpaceGlobCommand = 'rg --color=never --files'
"elseif executable('ag')
    "let g:CtrlSpaceGlobCommand = 'ag -l --nocolor -g ""'
"endif
"nnoremap <silent><C-p> :CtrlSpace O<CR>

" for fzf.vim:
nnoremap <silent> <leader>of :Files<CR>
nnoremap <silent> <leader>og :GFiles<CR>
nnoremap <silent> <leader>os :GFiles?<CR>
nnoremap <silent> <leader>ob :Buffers<CR>
nnoremap <silent> <leader>oa :Ag<CR>
nnoremap <silent> <leader>or :Rg<CR>
nnoremap <silent> <leader>ol :Lines<CR>
nnoremap <silent> <leader>oo :BLines<CR>
nnoremap <silent> <leader>oh :History<CR>
nnoremap <silent> <leader>o: :History:<CR>
nnoremap <silent> <leader>o/ :History/<CR>
nnoremap <silent> <leader>oc :Commits<CR>
nnoremap <silent> <leader>o? :Commands<CR>
nnoremap <silent> <leader>om :Maps<CR>
nnoremap <silent> <leader>ow :Windows<CR>
nnoremap <silent> <leader>o` :source ~/.vimrc<CR>

nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>/ :Lines<CR>
nnoremap <silent> <leader>? :Rg<CR>
nnoremap <silent> <leader>o :GFiles<CR>
nnoremap <silent> <CR> :Buffers<CR>

nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)

" for coc.nvim:
let g:coc_global_extensions = ['coc-ccls', 'coc-pyright', 'coc-json', 'coc-git']

" for coc-snippets:

let g:coc_snippet_next = '<tab>'

" for asynctasks.vim:

let g:asyncrun_open = 6
let g:asynctasks_term_pos = 'bottom'
let g:asynctasks_term_rows = 6
let g:asynctasks_term_cols = 50
let g:asynctasks_term_reuse = 1
let g:asynctasks_term_focus = 0
let g:asyncrun_rootmarks = ['.tasks', '.git/']

function! AsyncTaskMultiple(...)
    if len(a:000) >= 1
        let l:tmp = ""
        for task in a:000[1:]
            let l:tmp .= "'".l:task."',"
        endfor
        let l:tmp = l:tmp[:-1]
        let g:debugvar = "!!!".l:tmp."!!!".a:000[0]
        let g:asyncrun_exit="cclose | call AsyncTaskMultiple(".l:tmp.")"
        exec "AsyncTask ".a:000[0]
    else
        let g:asyncrun_exit=""
    endif
endfunction
command! -nargs=+ AsyncTasks   :call AsyncTaskMultiple(<f-args>)

" begin plugin list

call plug#begin('~/.vim/plugged')

Plug 'vim-scripts/surround.vim'
Plug 'vim-scripts/The-NERD-tree', {'on': 'NERDTreeToggle'}
Plug 'archibate/QFixToggle', {'on': 'QFix'}
Plug 'vim-scripts/fugitive.vim' ", {'on': 'Git'}
Plug 'bfrg/vim-cpp-modern', {'for': 'cpp'}
Plug 'vim-scripts/vim-airline'
"Plug 'cskeeters/vim-smooth-scroll'
Plug 'tikhomirov/vim-glsl', {'for': 'glsl'}
"Plug 'junegunn/vim-slash'
Plug 'vim-scripts/a.vim', {'for': ['c', 'cpp', 'cuda']}
Plug 'machakann/vim-swap'
Plug 'preservim/nerdcommenter'
"Plug 'preservim/vimux'
"Plug 'peterhoeg/vim-qml', {'for': 'qml'}
"Plug 'SirVer/ultisnips'
"Plug 'honza/vim-snippets'
"Plug 'neoclide/coc-snippets'
Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug 'mbbill/undotree', {'on': 'UndoTreeToogle'}
"Plug 'ilyachur/cmake4vim', {'on': ['CMake', 'CMakeBuild', 'CMakeInfo', 'CMakeRun']}
"Plug 'puremourning/vimspector'
"Plug 'ctrlpvim/ctrlp.vim', {'on': ['CtrlP']}
"Plug 'ycm-core/YouCompleteMe', {'do': './install.py --clang-completer', 'for': ['c', 'cpp', 'python']}
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'skywind3000/asynctasks.vim'
Plug 'skywind3000/asyncrun.vim'
"Plug 'skywind3000/vim-terminal-help'
"Plug 'aben20807/vim-runner'
"Plug 'christoomey/vim-tmux-runner'
"Plug 'viniciusgerevini/tmux-runner.vim'
"Plug 'vim-ctrlspace/vim-ctrlspace'

call plug#end()

" BEGIN_COC_NVIM {{{
" References: https://github.com/neoclide/coc.nvim#example-vim-configuration

set hidden
set nobackup
set nowritebackup
set updatetime=300
set cmdheight=1
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
"inoremap <silent><expr> <space> pumvisible() ? (<SID>check_back_space() ? "\<space>" : "\<space>" : coc#_select_confirm()

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> <leader>l[ <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>l] <Plug>(coc-diagnostic-next)


" GoTo code navigation.
nmap <silent> <leader>d <Plug>(coc-definition)
nmap <silent> <leader>D <Plug>(coc-declaration)
nmap <silent> <leader>y <Plug>(coc-type-definition)
nmap <silent> <leader>i <Plug>(coc-implementation)
nmap <silent> <leader>r <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>n <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f <Plug>(coc-format-selected)
"nmap <leader>f <Plug>(coc-format-selected)
nnoremap <leader>f :Format<CR>

" Restart CoC
"nmap <silent> <leader>t :CocRestart<CR><CR>

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>q  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format    :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold      :call CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OrgImport :call CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Using CocList
" Show all diagnostics
nnoremap <silent> <leader>la  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <leader>le  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <leader>lc  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <leader>lo  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <leader>ls  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <leader>lj  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <leader>lk  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <leader>lp  :<C-u>CocListResume<CR>
" Show git status
nnoremap <silent> <leader>lg  :<C-u>CocList --normal gstatus<CR>


" }}} END_COC_NVIM

if filereadable(".vim_localrc")
        source .vim_localrc
endif

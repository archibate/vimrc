"
" .vimrc used by a C++ coder: github.com/archibate
"
" I manage plugins using vim-plug:
" https://github.com/junegunn/vim-plug
"
" Please run :PlugInstall when you launch Vim for the
" first time to initialize all the plugins...
"
" Scroll to the end of this file to see plugin list.
"
" You may want to edit the YouCompleteMe installation
" step if you need language support other than C/C++.
"

set et ts=4 sts=4 sw=4
set fdm=syntax fdl=100
set nu ru ls=2
set hls is si
set ci cino=j1,(0,ws,Ws
set tm=360 ttm=10
set mouse=a
set bg=dark
"set noek
"set rulerformat=%55(%{strftime('%a\ %b\ %e\ %I:%M\ %p')}\ %5l,%-6(%c%V%)\ %P%)

syntax on
filetype on
filetype plugin on
filetype indent on

nnoremap <silent> <F1> :wa<CR>:A<CR>
nnoremap <silent> <F2> :wa<CR>:bp<CR>
nnoremap <silent> <F3> :wa<CR>:bn<CR>
nnoremap <silent> <F4> :wa<CR>
inoremap <silent> <F1> <ESC>
inoremap <silent> <F2> <ESC>:wa<CR>:bp<CR>
inoremap <silent> <F3> <ESC>:wa<CR>:bn<CR>
inoremap <silent> <F4> <ESC>:wa<CR>
nnoremap <silent> <F5> :wa<CR>:CMake<CR>
nnoremap <silent> <F6> :wa<CR>:CMakeBuild<CR>
nnoremap <silent> <C-F7> :wa<CR>:CMakeRun<CR>
nnoremap <silent> <S-F7> :wa<CR>:!make\|\|(echo -n .;read -n1)<CR><CR>
nnoremap <silent> <F7> :wa<CR>:!make<CR>
nnoremap <silent> <F8> :wa<CR>:sh<CR><CR>
nnoremap <silent> <F9> :wa<CR>:TagbarToggle<CR>:NERDTreeToggle<CR><C-w>l
nnoremap <silent> <F10> :wa<CR>:QFix<CR>
inoremap <silent> <F10> <ESC>:wa<CR>:QFix<CR>
nnoremap <silent> <S-F11> :wa<CR>:botright terminal<CR>
nnoremap <silent> <F12> /required from here<CR>
nnoremap <silent> <C-k> <C-w>k:q<CR>
nnoremap <silent> <C-j> <C-w>j
inoremap kj <ESC><ESC>
nnoremap Z ZZ
nnoremap Q @@

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

" for cmake4vim:
let g:cmake_usr_args = '-GNinja'
"let g:cmake_build_target = 'main'
let g:cmake_build_type = 'Debug'
let g:cmake_compile_commands = 1
let g:cmake_build_path_pattern = ["/tmp/build/%s", "getcwd()"]

" for YouCompleteMe:
let g:ycm_confirm_extra_conf = 0
let g:ycm_error_symbol = '✗'
let g:ycm_warning_symbol = '⚠'
let g:ycm_filetype_whitelist = {"c": 1, "cpp": 1, "python": 1}
let g:ycm_min_num_of_chars_for_completion = 2
let g:ycm_show_diagnostics_ui = 1
let g:ycm_key_invoke_completion = '<c-z>'
let g:ycm_enable_diagnostic_signs = 0
let g:ycm_enable_diagnostic_highlighting = 1
"let g:ycm_show_diagnostics_ui = 0
"let g:ycm_key_list_select_completion = ['<TAB>']
"let g:ycm_key_list_previous_completion = []

" for ultisnips:
let g:UltiSnipsExpandTrigger="<c-s>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsEditSplit="vertical"

" for vim-cpp-modern:
let g:cpp_attributes_highlight = 1
"let g:cpp_member_highlight = 1

" for vim-airline:
let g:airline#extensions#tabline#enabled = 1

" quick query all leader maps:
nnoremap <LEADER>? :nnoremap <LEADER><CR>

" for YouCompleteMe:
nnoremap <LEADER><LEADER> :YcmCompleter GoTo<CR>
nnoremap <LEADER>[ :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <LEADER>d :YcmCompleter GetDoc<CR>
nnoremap <LEADER>r :YcmCompleter RefactorRename<SPACE>
nnoremap <LEADER>f :YcmCompleter FixIt<CR>1
nnoremap <LEADER>y :call ToggleYcmDiagnostics()<CR><CR>:wa<CR>:e<CR>
func! ToggleYcmDiagnostics()
    let g:ycm_show_diagnostics_ui = !g:ycm_show_diagnostics_ui
    YcmRestartServer
endfunc

" for nerdcommenter:
nmap <LEADER>/ <LEADER>ci
vmap <LEADER>/ <LEADER>ci

" no longer used plugins:
"nnoremap <silent> =- :Unite<CR>
"nnoremap <silent> =/ :Unite grep<CR>
"nnoremap <silent> =; :Unite file<CR>
"let g:miniBufExplMapCTabSwitchBufs = 1
"let g:miniBufExplMapWindowNavVim = 1
"let g:miniBufExplForceSyntaxEnable = 1
"let g:miniBufExplorerMoreThanOne = 2
"let g:ConqueTerm_CloseOnEnd = 1
"let g:ConqueTerm_EscKey = '<C-k>'
"let g:OmniCpp_SelectFirstItem = 2
"let g:OmniCpp_MayCompleteDot = 1
"let g:OmniCpp_MayCompleteArray = 1
"let g:OmniCpp_MayCompleteScope = 1
"let g:OmniCpp_ShowPrototypeInAbbr = 1
"let g:OmniCpp_NamespaceSearch = 2
"let g:SuperTabDefaultCompletionType="<C-X><C-O>"
"set completeopt=menu,menuone
"nnoremap <F1> :wa<CR>:!ctags -R --exclude=build --c++-kinds=+plzZ --fields=+iaSEnzm --extras=+q -o /tmp/tags && ln -sf /tmp/tags .<CR><CR>
"nnoremap <LEADER>- :AsyncRun cmake --build build --parallel<CR>
"nnoremap <LEADER>= :CMake<CR>

" replaced by ultisnips:
"nnoremap <LEADER>a :wa<CR>:e %<.cpp<CR>
"nnoremap <LEADER>s :wa<CR>:e %<.h<CR>
"nnoremap <silent> <LEADER>d :wa<CR>0vf(%$YP0f(%$xxa;<ESC>$F)V%:s/virtual \\|static \\| override\\| noexcept//g<CR>%
"nnoremap <silent> <LEADER>e 0f(%j0vf(%$%Dk$F)%
"nnoremap <silent> <LEADER>g 0yyf:b:YcmCompleter GoTo<CR>$%k^
"nnoremap <silent> <LEADER>h p==f:bdt:dw$xr;
"nnoremap <silent> <LEADER>H p==f:bdt:dw$xr;i override<ESC>
"nnoremap <LEADER>9 0f(vi(
"nnoremap <LEADER>1 vi{<ESC>
"nnoremap <LEADER>2 vi{o<ESC>
"nnoremap <LEADER>3 va{<ESC>
"nnoremap <LEADER>4 va{o<ESC>
"nnoremap <LEADER>/ <ESC>O/*<CR>
"nnoremap <LEADER>/ I//<ESC>
"vnoremap <LEADER>/ :norm I//<ESC>
"inoremap `a std::
"inoremap `z ztd::
"inoremap `h <LEFT>
"inoremap `l <RIGHT>
"inoremap ``h <LEFT><LEFT>
"inoremap ``l <RIGHT><RIGHT>
"inoremap `; <ESC>A
"inoremap `, <><LEFT>
"inoremap `9 ()<LEFT>
"inoremap `0 ();
"inoremap `[ [&] (
"inoremap `. .get()
"inoremap `v std::visit([&] (auto const &val) {
"inoremap `s std::make_shared<
"inoremap `u std::make_unique<
"inoremap ``s std::shared_ptr<
"inoremap ``u std::unique_ptr<
"inoremap `w std::string
"inoremap `x <SPACE>const &
"inoremap `g std::function<void(
"inoremap `m std::move(
"inoremap `q std::forward<decltype(
"inoremap `c std::cout <<<SPACE>
"inoremap `e <SPACE><< std::endl;
"inoremap `1 auto<SPACE>
"inoremap `2 auto const &
"inoremap `3 auto &
"inoremap `4 auto &&
"inoremap `5 decltype(auto)<SPACE>
"inoremap `p <SPACE>*<RIGHT><BACKSPACE>
"inoremap `r <SPACE>&<RIGHT><BACKSPACE>
"inoremap ``1 for (auto<SPACE>
"inoremap ``2 for (auto const &
"inoremap ``3 for (auto &
"inoremap `f for (int i = 0; i < n; i++) {<ESC>Fns
"inoremap `i #include <
"inoremap `t template <class<SPACE>
"inoremap `d std::decay_t<
"inoremap ``d std::decay_t<decltype(
"inoremap `j <ESC>jA
"inoremap `o <ESC>o
"inoremap `k <ESC>O
"inoremap ``` ``````<LEFT><LEFT><LEFT>

call plug#begin('~/.vim/plugged')

Plug 'vim-scripts/Tagbar'
"Plug 'vim-scripts/OmniCppComplete'
"Plug 'vim-scripts/vim-bufferline'
"Plug 'ervandew/supertab'
Plug 'vim-scripts/surround.vim'
Plug 'vim-scripts/The-NERD-tree'
Plug 'archibate/QFixToggle'
Plug 'ycm-core/YouCompleteMe', {'do': './install.py --clang-completer'}
Plug 'vim-scripts/fugitive.vim'
"Plug 'vim-scripts/vim-cpp-enhanced-highlight'
Plug 'bfrg/vim-cpp-modern'
Plug 'vim-scripts/vim-airline'
Plug 'cskeeters/vim-smooth-scroll'
Plug 'tikhomirov/vim-glsl'
Plug 'junegunn/vim-slash'
Plug 'skywind3000/asyncrun.vim'
"Plug 'vhdirk/vim-cmake'
Plug 'vim-scripts/a.vim'
Plug 'machakann/vim-swap'
Plug 'preservim/nerdcommenter'
"Plug 'preservim/vimux'
"Plug 'oplatek/Conque-Shell'
Plug 'peterhoeg/vim-qml'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
"Plug 'zefei/vim-wintabs'
"Plug 'zefei/vim-wintabs-powerline'
"Plug 'Shougo/unite.vim'
"Plug 'Shougo/vimproc.vim', {'do': 'make'}
Plug 'ilyachur/cmake4vim'
"Plug 'puremourning/vimspector'
Plug 'ctrlpvim/ctrlp.vim'

call plug#end()

if filereadable(".vim_localrc")
        source .vim_localrc
endif

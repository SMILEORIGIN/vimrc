"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Author:                                                     "
"       smileorigin                                           "
"                                                             "
" Email:                                                      "
"       smileorigin@foxmail.com                               "
"                                                             "
" Github:                                                     "
"       https://github.com/SMILEORIGIN/vimrc                  "
"                                                             "
" Sections:                                                   "
"       -> General                                            "
"       -> Color                                              "
"       -> Shortcuts                                          "
"       -> Autocommands                                       "
"       -> Extended                                           "
"       -> Statusline                                         "
"       -> Plugins                                            "
"                                                             "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" General: {{{
    let $VIMFILES=$HOME.'/.vim'
    call system('mkdir -p ~/.vimtmp/undodir ~/.vimtmp/backupdir ~/.vimtmp/directory')

    set wildignore+=*.git\\*,*.tgz,*.zip,*.pyc,*.class
    set path+=./model/,./ctrl/,./lib/,*/templates/,*/static/,..,*/src/

    filetype on
    filetype plugin indent on
    filetype plugin on

    set title
    set backup
    set number
    set hlsearch
    set expandtab
    set cursorline
    set nocompatible
    set ffs=unix,dos,mac
    set t_Co=256

    set hidden
    set showcmd
    set autoread
    set noautochdir
    set noshowmatch
    set autowriteall

    set ignorecase smartcase
    set smartindent cindent autoindent
    set shiftwidth=4 tabstop=4 smarttab

    set vb t_vb=
    set bs+=start
    set scrolloff=1
    set textwidth=0
    set shell=/bin/bash
    set pastetoggle=<F5>
    set ambiwidth=double
    set foldmethod=manual
    set clipboard+=unnamed
    set encoding=utf-8 fileencodings=ucs-bom,utf-8,cp936 fileencoding=utf-8

    set nowrapscan
    set undodir=~/.vimtmp/undodir
                \ directory=~/.vimtmp/directory
                \ backupdir=~/.vimtmp/backupdir
                \ viewdir=~/.vimtmp/view
                \ undofile
" }}}


" Color: {{{
     syntax on
     set background=dark
     colorscheme ron
" }}}


" Shortcuts: {{{
    nmap <leader>w :w                               <cr>
    nmap <leader>q :q                               <cr>
    nmap <leader>ss :setlocal spell!                <cr>
    nmap <leader>df :!git diff %                    <cr>
    nmap <leader>3 :call NERDTreeToggleInCurDir()   <cr>

    nmap <c-t>h gT                                  <cr>
    nmap <c-t>l gt                                  <cr>
    nmap <c-l> <esc>:noh                            <cr>

    noremap gh <C-W>h
    noremap gk <C-W>k
    noremap gl <C-W>l
    noremap gj <C-W>j

    " ale
    nmap <leader>s :ALEToggle                       <cr>
    nmap <leader>d :ALEDetail                       <cr>
    nmap <silent> <C-k> <Plug>(ale_previous_wrap)
    nmap <silent> <C-j> <Plug>(ale_next_wrap)
" }}}


" Autocommands: {{{
    "compile
    au Filetype c      map <F5> <Esc>:w<cr>:!gcc % -std=c99 -g -o %< -lm && ./%<        <cr>
    au Filetype cpp    map <F5> <Esc>:w<cr>:!g++ % -std=c++11 -g -o %< -lm && ./%<      <cr>
    au Filetype python map <F5> <Esc>:w<cr>:!python3 %                                  <cr>
" }}}


" Extended: {{{
    set backspace=indent,eol,start

    highlight ExtraWhitespace ctermbg=red guibg=darkgreen
    autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
    match ExtraWhitespace /\s\+$\| \+\ze\t/

    if has("autocmd")
      autocmd BufReadPost *
          \ if line("'\"") > 0 && line("'\"") <= line("$") |
          \   exe "normal g`\"" |
          \ endif
    endif

    function! NERDTreeToggleInCurDir()
        " If NERDTree is open in the current buffer
        if (exists("t:NERDTreeBufName") && bufwinnr(t:NERDTreeBufName) != -1)
            exe ":NERDTreeClose"
        else
            if (expand("%:t") != '')
                exe ":NERDTreeFind"
            else
                exe ":NERDTreeToggle"
            endif
        endif
    endfunction
" }}}


" Statusline: {{{
    set laststatus=2
    set statusline=%f%m%r%h%w%=\ [%Y]\ %{\"[\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\"+\":\"\").\"]\"}\ [%{&ff}]\ [%l/%L:%v]
" }}}


" Plugins: {{{
    call plug#begin('~/.vim/plugged')
    Plug 'kien/ctrlp.vim',
    Plug 'godlygeek/tabular',
    Plug 'scrooloose/nerdtree',
    Plug 'tpope/vim-commentary',
    Plug 'airblade/vim-gitgutter',
    Plug 'plasticboy/vim-markdown',
    Plug 'mzlogin/vim-markdown-toc',
    Plug 'pangloss/vim-javascript',
    Plug 'leafgarland/typescript-vim',
    Plug 'quramy/tsuquyomi',
    Plug 'dense-analysis/ale'
    call plug#end()


    " NERDTree: {{{
        let g:NERDTreeBookmarksFile         = $HOME.'/.vimtmp/NerdBookmarks.txt'
        let g:NERDTreeShowBookmarks         = 1
        let g:NERDTreeShowFiles             = 1
        let g:NERDTreeShowLineNumbers       = 0
        let g:NERDTreeWinSize               = 30
        let g:NERDTreeMinimalUI             = 1
        let g:NERDTreeDirArrows             = 1
        let NERDTreeStatusline              = 'NERDTree'
        let g:NERDTreeIgnore                = [
                    \ '.*\.class',
                    \ '.*\.chm',
                    \ '.*\.ttf',
                    \ '.*\.lnk',
                    \ '.*\.cproj',
                    \ '.*\.exe',
                    \ '.*\.dll',
                    \ '.*\.out',
                    \ '.*\.files',
                    \ '.*\.zip',
                    \ '.*\.rar',
                    \ '.*\.gif',
                    \ '.*\.pyc',
                    \ '__pycache__'
                    \ ]
    " }}}

    " ctrlp.vim {{{
        let g:ctrlp_user_command            = ['.git', 'cd %s && git ls-files -co --exclude-standard']
        let g:ctrlp_cmd                     = 'CtrlPMixed'
        let g:ctrlp_match_window            = 'bottom,order:btt,min:5,max:5,results:10'
        let g:ctrlp_mruf_default_order      = 1
    " }}}

    " vim-gitgutter {{{
        let g:gitgutter_max_signs           = 5000
    " }}}

    " vim-markdown {{{
        let g:vim_markdown_folding_disabled = 1
    "}}}

    " ale {{{
        let g:ale_linters = {
        \   'c': ['clang'],
        \   'c++': ['clang'],
        \   'python': ['pylint'],
        \   'javascript': ['eslint'],
        \   'typescript': [],
        \}
        " \   'typescript': ['eslint', 'tsserver'],
        let g:ale_fixers = {
        \   'javascript': ['eslint'],
        \}

        let g:ale_completion_enabled                        = 1
        let g:ale_javascript_eslint_suppress_missing_config = 1
    " }}}

    " vim-javascript {{{
        let javascript_enable_domhtmlcss                    = 1
    " }}}
"}}}

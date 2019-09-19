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

    let g:vim_markdown_folding_disabled = 1

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
     " colorscheme darkblue
     colorscheme ron
     " colorscheme peachpuff
     " colorscheme torte
     " colorscheme delek
     " colorscheme desert
" }}}


" Shortcuts: {{{
    nmap <leader>c :set filetype=css        <cr>
    nmap <leader>d :set filetype=htmldjango <cr>
    nmap <leader>g :set filetype=go         <cr>
    nmap <leader>h :set filetype=html       <cr>
    nmap <leader>j :set filetype=javascript <cr>
    nmap <leader>l :set filetype=lua        <cr>
    nmap <leader>m :set filetype=markdown   <cr>
    nmap <leader>s :set filetype=sh         <cr>
    nmap <leader>t :set filetype=txt        <cr>
    nmap <leader>v :set filetype=vim        <cr>
    nmap <leader>p :set filetype=python     <cr>

    nmap <leader>w :w                       <cr>
    nmap <leader>q :q                       <cr>
    nmap <leader>3 :NERDTreeToggle          <cr>
    nmap <leader>e :Errors                  <cr>
    nmap <leader>ss :setlocal spell!        <cr>

    nmap <c-l> <esc>:noh                    <cr>

    noremap gh <C-W>h
    noremap gk <C-W>k
    noremap gl <C-W>l
    noremap gj <C-W>j
" }}}


" Autocommands: {{{
    " vue
    au BufNewFile,BufRead *.vue,*.js set nowrap
    au BufNewFile,BufRead *.vue,*.js set tabstop=2
    au BufNewFile,BufRead *.vue,*.js set shiftwidth=2
    au BufNewFile,BufRead *.vue,*.js set softtabstop=2
    au BufNewFile,BufRead *.vue,*.js set filetype=javascript

    "compile
    au Filetype c      map <F5> <Esc>:w<CR>:!gcc % -std=c99 -g -o %< -lm && ./%< <CR>
    au Filetype cpp    map <F5> <Esc>:w<CR>:!g++ % -std=c++11 -g -o %< -lm && ./%< <CR>
    au Filetype python map <F5> <Esc>:w<CR>:!python3 % <CR>
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
" }}}


" Statusline: {{{
    set laststatus=2
    set statusline=%F%m%r%h%w%=\ [ft=%Y]\ %{\"[fec=\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\"+\":\"\").\"]\"}\ [ff=%{&ff}]\ [%l/%L]
" }}}


" Plugins: {{{
    call plug#begin('~/.vim/plugged')
    Plug 'scrooloose/nerdtree',
    Plug 'kien/ctrlp.vim',
    Plug 'tpope/vim-commentary',
    Plug 'vim-syntastic/syntastic',
    Plug 'airblade/vim-gitgutter',
    Plug 'plasticboy/vim-markdown',
    Plug 'mzlogin/vim-markdown-toc',
    Plug 'godlygeek/tabular'
    call plug#end()


    " NERDTree: {{{
        let g:NERDTreeBookmarksFile   = $HOME.'/.vimtmp/NerdBookmarks.txt'
        let g:NERDTreeShowBookmarks   = 1
        let g:NERDTreeShowFiles       = 1
        let g:NERDTreeShowLineNumbers = 0
        let g:NERDTreeWinSize         = 30
        let g:NERDTreeMinimalUI       = 1
        let g:NERDTreeDirArrows       = 1
        let g:NERDTreeIgnore          = [
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
        let g:ctrlp_user_command       = [
                    \ '.git/',
                    \ 'git --git-dir   = %s/.git ls-files -oc --exclude-standard'
                    \ ]
        let g:ctrlp_cmd                = 'CtrlPMixed'
        let g:ctrlp_match_window       = 'bottom,order:btt,min:5,max:5,results:10'
        let g:ctrlp_mruf_default_order = 1
    " }}}

    " syntastic {{{
        set statusline+=%{SyntasticStatuslineFlag()}

        let g:syntastic_check_on_wq              = 0
        let g:syntastic_check_on_open            = 1
        let g:syntastic_always_populate_loc_list = 1

        let g:syntastic_cpp_compiler             = 'clang++'
        let g:syntastic_cpp_compiler_options     = '-std=c++11 -stdlib=libc++'
    " }}}

    " vim-gitgutter {{{
        let g:gitgutter_max_signs                = 5000
    " }}}
"}}}



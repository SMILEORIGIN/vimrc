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
"       -> CompileRun                                         "
"       -> Extended                                           "
"       -> Statusline                                         "
"       -> Plugins                                            "
"                                                             "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" General: {{{
    let $VIMFILES=$HOME.'/.vim'
    call system('mkdir -p ~/.vimtmp/undodir ~/.vimtmp/directory')

    set wildignore+=*.git\\*,*.tgz,*.zip,*.pyc,*.class
    set path+=./model/,./ctrl/,./lib/,*/templates/,*/static/,..,*/src/

    filetype on
    filetype plugin indent on
    filetype plugin on

    set title
    set number
    set hlsearch
    set expandtab
    set cursorline
    set nocompatible
    set ffs=unix,dos,mac
    set t_Co=256
    set cmdheight=1
    set nobackup
    set nowb
    set noswapfile

    set hidden
    set showcmd
    set autoread
    set noautochdir
    set noshowmatch
    set autowriteall
    set lazyredraw

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
                \ viewdir=~/.vimtmp/view
                \ undofile
" }}}


" Color: {{{
    syntax on
    set background=dark

    " try
    "     colorscheme ron
    " catch
    " endtry
" }}}


" Shortcuts: {{{
    nmap <leader>w :w                               <cr>
    nmap <leader>q :q                               <cr>
    nmap <leader>ss :setlocal spell!                <cr>
    nmap <leader>df :!git diff %                    <cr>
    nmap <leader>3 :call NERDTreeToggleInCurDir()   <cr>

    map <leader>tn :tabnew                          <cr>
    map <leader>to :tabonly                         <cr>
    map <leader>tc :tabclose                        <cr>

    map <leader>l :bnext                            <cr>
    map <leader>h :bprevious                        <cr>

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


" CompileRun: {{{
    map <F5> :call CompileRun()<CR>
    imap <F5> <Esc>:call CompileRun()<CR>
    vmap <F5> <Esc>:call CompileRun()<CR>

    func! CompileRun()
    exec "w"
    if &filetype == 'c'
        silent exec "!gcc % -std=c11 -g -o /tmp/%:t:r -lm"
        exec "!time /tmp/%:t:r"
    elseif &filetype == 'cpp'
        silent exec "!g++ % -std=c++17 -g -o /tmp/%:t:r -lm"
        exec "!time /tmp/%:t:r"
    elseif &filetype == 'java'
        silent exec "!javac %"
        exec "!time java %"
    elseif &filetype == 'javascript'
        exec "!time node %"
    elseif &filetype == 'sh'
        exec "!time bash %"
    elseif &filetype == 'python'
        exec "!time python3 %"
    elseif &filetype == 'go'
        silent exec "!go build %<"
        exec "!time go run %"
    endif
    endfunc
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
    Plug 'dense-analysis/ale',
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
        \   'cpp': ['clang', 'g++'],
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
        let g:ale_cpp_cc_executable                         = 'clang'
        let g:ale_cpp_clang_options                         = '-std=c++17 -Wall'
    " }}}

    " vim-javascript {{{
        let javascript_enable_domhtmlcss                    = 1
    " }}}
"}}}

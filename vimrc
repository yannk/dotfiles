set nocompatible  " disable vi compatibility.

call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-markdown'
Plug 'altercation/vim-colors-solarized'
Plug 'ntpeters/vim-better-whitespace'
Plug 'scrooloose/syntastic'
Plug 'pangloss/vim-javascript'
Plug 'fatih/vim-go'
Plug 'nsf/gocode', { 'rtp': 'vim', 'do': '~/.vim/plugged/gocode/vim/symlink.sh' }
Plug 'majutsushi/tagbar'
Plug 'Shougo/neocomplete.vim'
"Plug 'Valloric/YouCompleteMe'
Plug 'tpope/vim-unimpaired'
Plug 'bling/vim-airline'
Plug 'bkad/CamelCaseMotion'
Plug 'sjl/vitality.vim'
Plug 'airblade/vim-gitgutter'
Plug 'keith/swift.vim'
call plug#end()

" General "{{{
    set encoding=utf-8
    set history=1000  " Number of things to remember in history.
    if has('persistent_undo')
        set undofile                "so is persistent undo ...
        set undolevels=1000         "maximum number of changes that can be undone
        set undoreload=10000        "maximum number lines to save for undo on a buffer reload
    endif
    "" Save many many lines in viminfo
    set viminfo='30,\"1000,:30,%
    set autowrite  " Writes on make/shell commands
    set autoread
    set timeoutlen=250  " Time to wait after ESC (default causes an annoying delay)
    set clipboard+=unnamed  " Yanks go on clipboard instead.
    "set pastetoggle=<F10> "  toggle between paste and normal: for 'safer' pasting from keyboard
    "set tags=./tags;$HOME " walk directory tree upto $HOME looking for tags
    " Modeline
    "set modeline
    "set modelines=5 " default numbers of lines to read for modeline instructions
    " Buffers
    set hidden      " The current buffer can be put to the background without writing to disk
    set hlsearch    " highlight search
    set noignorecase
    "set smartcase  " be sensitive when there's a capital letter
    set incsearch   "
    set shiftround
    set ttyfast     " this is 2013
    if version >= 700
        set cursorline " testing to see if I like it
    endif

    let g:is_posix = 1  " vim's default is archaic bourne shell, bring it up to the 90s
    let g:neocomplete#enable_at_startup = 1
    set completeopt=menu
" "}}}

" Formatting "{{{
    set fo+=o " Automatically insert the current comment leader after hitting 'o' or 'O' in Normal mode.
    set fo+=c " Auto-wrap comments using textwidth
    set fo-=r " Do not automatically insert a comment leader after an enter
    set fo-=t " Do no auto-wrap text using textwidth (does not apply to comments)
    "set fo+=j " Where it makes sense, remove a comment leader when joining lines

    set wildmenu                    " show list instead of just completing
    set wildmode=longest,list       " At command line, complete longest common string, then list alternatives.
    set scrolljump=5                " lines to scroll when cursor leaves screen
    set scrolloff=3                 " minimum lines to keep above and below cursor

    set backspace=indent,eol,start  " more powerful backspacing

    set shiftwidth=4                " use indents of 4 spaces
    set tabstop=4                   " an indentation every four columns
    set softtabstop=4               " let backspace delete indent
    set expandtab                   " Make tabs into spaces (set by tabstop)
    set smarttab                    " Smarter tab levels

    set autoindent
    set cindent
    set cinoptions=:s,ps,ts,cs
    set cinwords=if,else,while,do,for,switch,case

    syntax on                    " enable syntax
    filetype plugin indent on    " Automatically detect file types. required for vundle
" "}}}

" Visual "{{{
    set showmatch     " Show matching brackets.
    set matchtime=5   " Bracket blinking.
    set novisualbell  " No blinking
    set noerrorbells  " No noise.
    set laststatus=2  " Always show status line.
    set vb t_vb=      " disable any beeps or flashes on error
    set winminheight=0              " windows can be 0 line high

    set ruler   " Show ruler
    set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " a ruler on steroids
    set showcmd " show partial commands in status line and
                " selected characters/lines in visual mode

    set shortmess+=filmnrxoOtT      " abbrev. of messages (avoids 'hit enter')
    set viewoptions=folds,options,cursor,unix,slash " better unix / windows compatibility

    set spell                       " spell checking on


    if has('statusline')
        set laststatus=2

        " Broken down into easily includeable segments
        set statusline=%<%f\    " Filename
        set statusline+=%w%h%m%r " Options
        set statusline+=%{fugitive#statusline()} "  Git Hotness
        set statusline+=\ [%{&ff}/%Y]            " filetype
        set statusline+=\ [%{getcwd()}]          " current dir
        set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
    endif

    set nolist " Display unprintable characters f12 - switches
    set listchars=tab:·\ ,eol:¶,trail:·,extends:»,precedes:« " Unprintable chars mapping

    set foldenable " Turn on folding
    set foldmethod=marker " Fold on the marker
    set foldlevel=100 " Don't autofold anything (but I can still fold manually)
    set foldopen=block,hor,mark,percent,quickfix,tag " what movements open folds

    set mouse-=a   " Disable mouse
    set mousehide  " Hide mouse after chars typed

    set splitbelow
    set splitright
" "}}}


" Command and Auto commands " {{{
    " Sudo write
    comm! WW exec 'w !sudo tee % > /dev/null' | e!

    "Auto commands
    au BufRead,BufNewFile {Gemfile,Rakefile,Capfile,*.rake,config.ru}     set ft=ruby
    au BufRead,BufNewFile {COMMIT_EDITMSG}                                set ft=gitcommit
    "au BufRead,BufNewFile {*.md,*.mkd,*.markdown}                         set ft=markdown

    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | execute "normal g'\"" | endif " restore position in file

    autocmd filetype crontab setlocal nobackup nowritebackup
    autocmd FileType {txt,rst,markdown} set formatoptions+=t textwidth=72
    autocmd FileType go setlocal softtabstop=0 tabstop=4 shiftwidth=4 noexpandtab
    au FileType go nmap <Leader>gi <Plug>(go-info)
    au FileType go nmap <Leader>gdd <Plug>(go-doc)
    au FileType go nmap <Leader>gdv <Plug>(go-doc-vertical)
    au FileType go nmap <Leader>gr <Plug>(go-run)
    au FileType go nmap <Leader>gb <Plug>(go-build)
    au FileType go nmap <Leader>gt <Plug>(go-test)
    au FileType go nmap <Leader>gc <Plug>(go-coverage)
    au FileType go nmap gd <Plug>(go-def)
    au FileType go nmap <Leader>ds <Plug>(go-def-split)
    au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
    au FileType go nmap <Leader>dt <Plug>(go-def-tab)
    let g:go_fmt_command = "goimports"

    let g:tagbar_type_go = {
        \ 'ctagstype' : 'go',
        \ 'kinds'     : [
            \ 'p:package',
            \ 'i:imports:1',
            \ 'c:constants',
            \ 'v:variables',
            \ 't:types',
            \ 'n:interfaces',
            \ 'w:fields',
            \ 'e:embedded',
            \ 'm:methods',
            \ 'r:constructor',
            \ 'f:functions'
        \ ],
        \ 'sro' : '.',
        \ 'kind2scope' : {
            \ 't' : 'ctype',
            \ 'n' : 'ntype'
        \ },
        \ 'scope2kind' : {
            \ 'ctype' : 't',
            \ 'ntype' : 'n'
        \ },
        \ 'ctagsbin'  : 'gotags',
        \ 'ctagsargs' : '-sort -silent'
    \ }


    " Remove <tab> highlighting in cases were tabs are normal
    " and expected. This is a problem with solarized cs only. {Apparently fixed?}
    "autocmd FileType go hi! SpecialKey cterm=none
    "autocmd FileType gitcommit hi! SpecialKey cterm=none
    "autocmd FileType make hi! SpecialKey cterm=none

    autocmd FileType gitcommit setlocal fo+=t " automatic word wrapping as I type

    " Quick fix close on quit.
    " http://stackoverflow.com/questions/7476126/how-to-automatically-close-the-quick-fix-window-when-leaving-a-file
    aug QFClose
        au!
        au WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&buftype") == "quickfix"|q|endif
    aug END
" " }}}

" Key mappings " {{{

    let mapleader = ','
    let maplocalleader = '	'
    nnoremap <silent> <LocalLeader>rs :source ~/.vimrc<CR>
    nnoremap <silent> <LocalLeader>rt :tabnew ~/.vim/vimrc<CR>
    nnoremap <silent> <LocalLeader>re :e ~/.vim/vimrc<CR>
    nnoremap <silent> <LocalLeader>rd :e ~/.vim/ <CR>

    " Tabs
    nnoremap <silent> <LocalLeader>[ :tabprev<CR>
    nnoremap <silent> <LocalLeader>] :tabnext<CR>
    " Duplication
    vnoremap <silent> <LocalLeader>= yP
    nnoremap <silent> <LocalLeader>= YP
    " Buffers
    nnoremap <silent> <LocalLeader>- :bd<CR>
    " Split line(opposite to S-J joining line)
    nnoremap <silent> <C-J> gEa<CR><ESC>ew

    " map <silent> <C-W>v :vnew<CR>
    " map <silent> <C-W>s :snew<CR>

    nnoremap # :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>
    nnoremap * #

    map <S-CR> A<CR><ESC>
    "
    " Control+S and Control+Q are flow-control characters: disable them in your terminal settings.
    " $ stty -ixon -ixoff
    noremap <C-S> :update<CR>
    vnoremap <C-S> <C-C>:update<CR>
    inoremap <C-S> <C-O>:update<CR>
    "
    " show/Hide hidden Chars
    map <silent> <F12> :set invlist<CR>
    "
    " generate HTML version current buffer using current color scheme
    map <silent> <LocalLeader>2h :runtime! syntax/2html.vim<CR>

    " I don't want to encrypt, I want to :wq
    nmap :X :x
    nmap :W :w
    nmap :Q :q

    " sudo then write
    cabbrev w!! w !sudo tee % >/dev/null

    " Convert file format to unix
    nmap _ux :se ff=unix<CR>

    " automatically insert \v when searching for normal regexp. :help \v
    nnoremap / /\v
    vnoremap / /\v

    " Let's try this. But on my kinesis those keys are "fine"
    noremap <Up> <nop>
    noremap <Down> <nop>
    noremap <Left> <nop>
    noremap <Right> <nop>

    nnoremap <silent> <Leader>ew :StripWhitespace<CR>
    nnoremap <silent> <Leader>t :TagbarToggle<CR>

    "" By default enable hybrid line numbers,
    "" but define easy mapping to kill the gutter
    set relativenumber
    set number

    function! NumbersOff()
        set norelativenumber
        set nonumber
    endfunc

    function! NumbersOn()
        set relativenumber
        set number
    endfunc

    function! ToggleNumbers()
        if(&relativenumber)
            call NumbersOff()
        else
            call NumbersOn()
        endif
    endfunc

    function! ToggleGutters()
        if g:gitgutter_enabled
            call NumbersOff()
            GitGutterDisable
        else
            call NumbersOn()
            GitGutterEnable
        endif
    endfunc

    nnoremap <silent> <Leader>n :call ToggleNumbers()<CR>
    " toggle ALL gutter stuff
    nnoremap <silent> <Leader>g :call ToggleGutters()<CR>
" }}}

" chrome {{{
    set background=dark
    let g:solarized_termtrans=1
    let g:solarized_contrast="high"
    let g:solarized_visibility="high"
    "let g:solarized_termcolors=256 " this is degraded mode
    " http://ethanschoonover.com/solarized/vim-colors-solarized
    colorscheme solarized

    let g:airline#extensions#tabline#enabled = 1
    if !exists('g:airline_symbols')
        let g:airline_symbols = {}
    endif

    " unicode symbols
    let g:airline_left_sep = '»'
    let g:airline_left_sep = '▶'
    let g:airline_right_sep = '«'
    let g:airline_right_sep = '◀'
    let g:airline_symbols.linenr = '␊'
    let g:airline_symbols.linenr = '␤'
    let g:airline_symbols.linenr = '¶'
    let g:airline_symbols.branch = '⎇'
    let g:airline_symbols.paste = 'ρ'
    let g:airline_symbols.paste = 'Þ'
    let g:airline_symbols.paste = '∥'
    let g:airline_symbols.whitespace = 'Ξ'
" }}}

" Stolen from SPF13
function! InitializeDirectories()
    let separator = "."
    let parent = $HOME
    let prefix = '.vim'
    let dir_list = {
                \ 'backup': 'backupdir',
                \ 'views': 'viewdir',
                \ 'swap': 'directory' }

    if has('persistent_undo')
        let dir_list['undo'] = 'undodir'
    endif

    for [dirname, settingname] in items(dir_list)
        let directory = parent . '/' . prefix . dirname . "/"
        if exists("*mkdir")
            if !isdirectory(directory)
                call mkdir(directory)
            endif
        endif
        if !isdirectory(directory)
            echo "Warning: Unable to create backup directory: " . directory
            echo "Try: mkdir -p " . directory
        else
            let directory = substitute(directory, " ", "\\\\ ", "g")
            exec "set " . settingname . "=" . directory
        endif
    endfor
endfunction
set backup
call InitializeDirectories()

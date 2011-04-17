try
    runtime vim7-pathogen.vim
catch /^Vim(\a\+):E107/
    " ignore
endtry
filetype on " fix vim bad exist status
filetype off " force a reload of filetypes on debian

"  TIP/REMINDER :
"  copier sur la ligne de commande le mot courant ou le buffer
"  <C-r><C-w> ou <C-r>y (buffer)
"
" Uncomment a bunch of lines: <C-v><select comments>d
" Move to nth column: n|

se nocompatible

filetype on
filetype plugin on
filetype indent on
se incsearch

" have syntax highlighting in terminals which can display colours:
if has('syntax') && (&t_Co > 2)
  syntax on
  se hlsearch
  if (&t_Co <= 8)
    " I *HATE* the default darkblue (unreadable on dark backgrounds)
    hi Comment ctermfg=DarkGreen
  endif
  " hack that seem to be necessary under screen *sometimes*
  if (&t_Co < 256 && $TERM =~ '256')
    set t_Co=256
  endif
endif


" railscasts is usually my default
"colorscheme railscasts
" colorscheme inkpot
" giving a shot to solarized
    let g:solarized_termcolors=256
    set background=dark
    colorscheme solarized


" this is sometimes necessary, but thanks it's not for me anymore
" fix backspace
"if &term == "screen"
"  set t_kb=
"  fixdel
"endif

" use "[RO]" for "[readonly]" to save space in the message line:
set shortmess+=r

" show my paren
set showmatch

set nojs " Join lines with only one space

" have XX lines of command-line (etc) history:
set history=200

" remember all of these between sessions, but only 10 search terms; also
" remember info for 10 files, but never any on removable disks, don't remember
" marks in files, don't rehighlight old search patterns, and only save up to
" 100 lines of registers; including @10 in there should restrict input buffer
" but it causes an error for me:
set viminfo=/10,'10,r/mnt/zip,r/mnt/floppy,f0,h,\"900

" have command-line completion <Tab> (for filenames, help topics, option names)
" first list the available options and complete the longest common part, then
" have further <Tab>s cycle through the possibilities:
set wildmode=list:longest,full

" display the current mode and partially-typed commands in the status line:
set showmode
set showcmd

set laststatus=2
"" http://got-ravings.blogspot.com/2008/08/vim-pr0n-making-statuslines-that-own.html
set statusline=%t       "tail of the filename
set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
set statusline+=%{&ff}] "file format
set statusline+=%h      "help file flag
set statusline+=%m      "modified flag
set statusline+=%r      "read only flag
set statusline+=%y      "filetype
set statusline+=%=      "left/right separator
set statusline+=%c,     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file

"" fugitive
if version > 700
    set statusline+=\ %{fugitive#statusline()}
endif

" http://vim.wikia.com/wiki/Change_statusline_color_to_show_insert_or_normal_mode
" now set it up to change the status line based on mode
if version >= 700
  au InsertEnter * hi StatusLine term=reverse ctermbg=Black ctermbg=55 gui=undercurl guisp=Magenta
  au InsertLeave * hi StatusLine term=reverse ctermfg=White ctermbg=23 gui=bold,reverse
                   hi StatusLine term=reverse ctermfg=White ctermbg=23 gui=bold,reverse
endif

" don't have files trying to override this .vimrc:
set nomodeline

set softtabstop=4
set tabstop=4
set expandtab
set noignorecase
set autoindent
set shiftwidth=4
set shiftround
set backspace=indent,eol,start
set ttyfast
if version >= 700
    set cursorline " testing to see if I like it
endif

" visual bell
set vb t_vb=
set ruler

if has('unix')
    set bk bdir=~/tmp,.,/tmp       " Backup settings
    set dir=~/tmp,.,/tmp,/var/tmp  " Swap file
endif

let Vimplate="$HOME/.vim/vimplate/vimplate"

" When editing a file, always jump to the last cursor position.
" This must be after the uncompress commands.
autocmd BufReadPost * if line("'\"") && line("'\"") <= line("$") | exe "normal `\"" | endif


" == MAPPINGS
"
" redo
" (not everybody will like this. I'm lost without it)

let mapleader = ","
" map r :redo<CR>

" I don't use the command-line window
nmap q: :q
nmap :Q :q

" I don't want to encrypt, I want to :wq
nmap :X :x

" Convert file format to unix
nmap _ux :se ff=unix<CR>

"highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
"match ExtraWhitespace /\s\+\%#\@<!$/
"nnoremap <silent> ,ew :let _s=@/<Bar>:%s=\s\+$==e<Bar>:let @/=_s<Bar>:nohl<CR>fdfsdfsdfsdfsdfsf 

set listchars=tab:»·,trail:¬,precedes:⇠,extends:➠
set list

" == OLD STUFF I don't use anymore
" Remove search pattern highlighting (because we have set hls previously)
nmap <F4> :noh<CR>

" http://www.stripey.com/vim/vimrc.html
nnoremap \tp :set invpaste paste?<CR>
nmap <F5> \tp
imap <F5> <C-O>\tp
set pastetoggle=<F5>
"
" Opens a buffer with the diff for the current file
nmap _di :new\|r!svk di #<CR>ggdd:se nomod ft=diff<CR>

" in human-language files, automatically format everything at 72 chars:
"" autocmd FileType human set formatoptions+=t textwidth=72

" for actual C (not C++) programming where comments have explicit end
" characters, if starting a new line in the middle of a comment automatically
" insert the comment leader characters:
autocmd FileType c set formatoptions+=ro

" for CSS, also have things in braces indented:
autocmd FileType css set smartindent

" for HTML, generally format text, but if a long line has been created leave it
" alone when editing:
autocmd FileType html set formatoptions+=tl

" for both CSS and HTML, use genuine tab characters for indentation, to make
" files a few bytes smaller:
autocmd FileType html,css set expandtab softtabstop=4

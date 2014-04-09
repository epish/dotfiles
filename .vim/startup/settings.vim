"============== general settings ===============
set showcmd
set dict=/usr/share/dict/words
set cursorline
set ruler
set incsearch
set wildmenu
syntax enable
set synmaxcol=0
"set term=xterm
set display=uhex
set shortmess=aAIsT
set cmdheight=2
set nowrap
if &diff
	set wrap
endif
let &scrolloff=999-&scrolloff
set smartcase

set completeopt=menu
set mousemodel=popup
set backspace=2
set number
set nocompatible

set enc=utf-8
set fillchars=vert:¦

set textwidth=79  " lines longer than 79 columns will be broken
set expandtab     " insert spaces when hitting TABs
set tabstop=4     " an hard TAB displays as 4 columns
set softtabstop=4 " insert/delete 4 spaces when hitting a TAB/BACKSPACE
set shiftwidth=4  " operation >> indents 4 columns; << unindents 4 columns
set shiftround    " round indent to multiple of 'shiftwidth'
set autoindent    " align the new line indent with the previous line
set pastetoggle=<F2> "toogles paste mode to avoid unwanted indentation
set foldcolumn=1
set cc=+1,+2

set linespace=0
set history=1000
set list listchars=tab:› ,trail:-,extends:>,precedes:<,eol:¬
set colorcolumn=80

set laststatus=2
set ffs=unix
set mouse=a
set vb
set ttym=xterm2

set wrap

set tags=~/.vim/tags/tags

if version > 720
	set undofile
	set undodir=~/vimundo/
endif

let mapleader='\'
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

"let g:Powerline_symbols = 'fancy'
call Pl#Theme#InsertSegment('ws_marker', 'after', 'lineinfo')

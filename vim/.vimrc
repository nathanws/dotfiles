" My AMAZING .vimrc

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" start pathogen plugin stuff
" https://github.com/tpope/vim-pathogen
execute pathogen#infect()

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

endif " has("autocmd")

" Set syntax highlighting for the .other_stuff file
" Don't want to remove all autocommands. Instead, use a variable to ensure that 
" Vim includes the autocommands only once:
if !exists("autocommands_loaded") 
  let autocommands_loaded = 1
  au BufReadPost .other_stuff set syntax=sh
endif

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif


"------- GENERAL -------"

" If a file has been changed outside of vim, automatically read it again.
"set autoread

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" By default, pressing TAB in command mode will choose the first possible
" completion with no indication of how many others there might be. The
" following shows what the other options are:
set wildmenu

" To have the completion behave similarly to a shell, i.e. complete only up to
" the point of ambiguity (while still showing you the options are):
set wildmode=list:longest

" Allows Vim to manage mulitple buffers effectively. If set to 'nohidden',
" when a tab is closed the buffer is removed.
set hidden

" Keep all swap files and backups in one location
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

" set noerrorbells	" Disable error bell

" Make bell visual. Instead of making a noise, the window will briefly flash.
set visualbell

set undolevels=100	" Set number of undos

set history=333		" keep 333 lines of command line history

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Allow the cursor to go into 'invalid' places
" set virtualedit=all


"------- UI -------"

"set background=dark
colors lucius

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

if ! has("gui_running")
  set t_Co=256
endif

set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set number		" Show line numbers
set title		" Show the file name in the title
" set mousehide		" Hide the mouse pointer while typing
set cursorline          " Highlight current line
"hi CursorLine term=none cterm=none ctermbg=3	" adjust color
set matchtime=2         " Time, in seconds, to show matching bracket

" Shorten command-line text prompts, and do not show intro. See :help shortmess
set shortmess=atI

" Always display the status line
set laststatus=2

" Adjust keycode timeout length, makes chaning modes snappier
set ttimeoutlen=50


"------- SEARCHING BEHAVIOR -------"

set incsearch		" do incremental searching

" The two options, when set together, will make /-style searches
" case-sensitive only if there is a capital letter in the search expression.
" *-style searches will continue to be consistently case-sensitive.
" set ignorecase
" set smartcase


"------- INDENTS, TABS, AND SPACING -------"

" set textwidth=120	" Set columns to 120
set autoindent		" always set autoindenting on
set smartindent         " Indent after brackets, etc..
" set cindent           " Like smartindent, but stricter and more customizable

" When the cursor is moved outside the viewport of the current window, the
" buffer is scrolled by a single line. This option below will start the
" scrolling X lines before the border, keeping more context around it.
set scrolloff=3

" Set options for side scrolling. Works the same as scrolloff above.
set sidescroll=5
set listchars+=precedes:<,extends:>

" Set tab width
set shiftwidth=2
set softtabstop=2

set expandtab		" Use spaces instead of tabs

" Do not wrap line text. DOES NOT change the text in the buffer
" set nowrap

" Wrap lines at the right spot, not in the middle of a word
set linebreak


"---------- KEY BINDINGS -----------"

" arrow keys for window navigation
map <Right> <c-w>l
map <Left> <c-w>h
map <Up> <c-w>k
map <Down> <c-w>j

" make current selection all lowercase
nnoremap <C-j> guw
" make current selection all uppercase
nnoremap <C-k> gUw

" Don't use Ex mode, use Q for formatting
map Q gq

" Use , for Leader
let mapleader = ","

" Make <C-e> and <C-y> scroll the viewport by X lines.
nnoremap <C-e> 5<C-e>
nnoremap <C-y> 5<C-y>

" Use H and L for start and end of line, instead of top and bottom of screen.
map H ^
map L $

" Set arrow keys to buffer/switching management
" map <Right> :bnext<CR>
" imap <Right> <ESC>:bnext<CR>
" map <Left> :bprev<CR>
" imap <Left> <ESC>:bprev<CR>
" map <Del> :bd<CR>

" Set Up/Down keys to tab management
" map <Up> :tabp<CR>
" imap <Up> <ESC>:tabp<CR>
" map <Down> :tabn<CR>
" imap <Down> <Esc>:tabn<CR>

" Remap jj to Escape in insert mode
inoremap jj <Esc>

" These will make it so that going to the next one in a search will center on
" the line it's found in.
map N Nzz
map n nzz

" Switch : and ;
noremap ; :
nnoremap : ;

" Disable search highlighting with keypress
nnoremap - :nohl<CR>

" Insert new line in command mode
nnoremap <S-CR> O<ESC>
nnoremap <CR> o<ESC>

" Yank from cursor to the end of the line
nnoremap Y y$

" Move line of text using + and _ (<S-=> and <S-->)
nnoremap + :m+<CR>
nnoremap _ :m-2<cr>
vmap + :m'>+<CR>`<my`>mzgv`yo`z
vmap _ :m'<-2<CR>`>my`<mzgv`yo`z

" Comment out current line, goes to first column of line
nnoremap <F5> 1<bar><Insert>// <ESC>
" Remove comments from beginning of line
nnoremap <F6> 1<bar>xxx

" ------- NERDTree ------------
" Open it
nnoremap <C-n> :NERDTreeToggle<cr>
nnoremap <leader>d :NERDTreeToggle<cr>

" ------- SuperTab ------------
" Set the default Tab behavior to look for User stuff first, this
" makes it show eclim stuff first.
let g:SuperTabDefaultCompletionType = "<c-x><c-u>"

" This automatically closes the Preview window of a popup selection
" when a selection is made
let g:SuperTabClosePreviewOnPopupClose = 1

" This stops omnicomplete from automatically choosing an entry (longest)
" but still show the popup selections (menuone)
set completeopt=longest,menuone


" ------- PLUGINS -------"

" This will make the % key switch between if/else, HTML and other tags.
runtime plugins/matchit.vim

" Automatically closes [ ( { " '
runtime plugins/autoclose.vim

" Awesome thing that makes commenting out lines EASY!
runtime plugins/NERD_commenter.vim

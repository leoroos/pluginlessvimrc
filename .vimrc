"" General
let mapleader=" "

" Switch syntax highlighting on
syntax on
set nocompatible

" activate mouse in all modes
set mouse=a

set number      " Show line numbers
set nowrap      " Wrap lines
set showcmd     " Show incomplete command
set linebreak   " Break lines at word (requires Wrap lines)
set showbreak=+++       " Wrap-broken line prefix
set textwidth=100       " Line wrap (number of cols)
set showmatch   " Highlight matching brace
set visualbell  " Use visual bell (no beeping)

set hlsearch    " Highlight all search results
set smartcase   " Enable smart-case search
set ignorecase  " Always case-insensitive
set incsearch   " Searches for strings incrementally

set autoindent  " Auto-indent new lines
set expandtab   " Use spaces instead of tabs
set shiftwidth=2        " Number of auto-indent spaces
set smartindent " Enable smart-indent
set smarttab    " Enable smart-tabs
set softtabstop=2       " Number of spaces per Tab
set listchars=trail:.,eol:$,tab:>-

"" Advanced
set ruler       " Show row and column ruler information

set autochdir   " Change working directory to open buffer

set undolevels=1000     " Number of undo levels
set backspace=indent,eol,start  " Backspace behaviour

" Always show status bar
set laststatus=2

" Get rid of the delay when pressing O (for example)
" http://stackoverflow.com/questions/2158516/vim-delay-before-o-opens-a-new-line
set timeout timeoutlen=1000 ttimeoutlen=100

" Set the status line to something useful
set statusline=%f\ %m\ %=L:%l/%L\ C:%c\ (%p%%)
 
filetype plugin indent on

nnoremap Q <nop>
nnoremap <F1> <ESC>
nnoremap col :set list!<CR>
nnoremap <C-s> :update<CR>
nnoremap <C-Q> :q<CR>
nnoremap QQ     :q<CR>
nnoremap QA :qa<CR>
nnoremap q: :q

"remove trailing whitespace
nnoremap <silent> <F6> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

nnoremap <C-j> <C-W><C-J>
nnoremap <C-k> <C-W><C-K>
nnoremap <C-l> <C-W><C-L>
nnoremap <C-h> <C-W><C-H>

nnoremap <leader>nt :tabe<CR>

nnoremap <leader>sv :source $MYVIMRC<CR>
nnoremap <leader>ev :vsplit $MYVIMRC<CR>
nnoremap Y y$
nnoremap j gj
nnoremap k gk

nnoremap <leader><leader>r :%s/
nnoremap <leader>rw :%s/<c-r><c-w>
nnoremap <leader>rW :%s/<c-r><c-a>

nnoremap <leader><leader>s :update<CR>

nnoremap <leader>cq :ccl<CR>
nnoremap <leader>cl :lclose<CR>
nnoremap <leader>cp :pclose<CR>
nnoremap <leader><leader>c :lclose <bar>:cclose <bar>:pclose<CR>

nnoremap <leader><leader>u :e %<CR>

nnoremap <leader>hl :set hlsearch!<CR>
nnoremap <leader>nh :nohlsearch<CR>
nnoremap <a-up> ddkkp
nnoremap <a-down> ddp

nnoremap <leader>cpf :!realpath % <bar> xsel -b <cr><cr>
nnoremap <leader>vx :Vexplore<CR>
nnoremap <leader>sx :Sexplore<CR>
nnoremap <leader><leader>x :Explore<CR>

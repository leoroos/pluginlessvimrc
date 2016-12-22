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
nnoremap cow :set wrap!<CR>

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

set pastetoggle=<F2>

" vim-tmux integration {{{
" Maps <C-h/j/k/l> to switch vim splits in the given direction. If there are
" no more windows in that direction, forwards the operation to tmux.
" Additionally, <C-\> toggles between last active vim splits/tmux panes.

if exists("g:loaded_tmux_navigator") || &cp || v:version < 700
  finish
endif
let g:loaded_tmux_navigator = 1

if !exists("g:tmux_navigator_save_on_switch")
  let g:tmux_navigator_save_on_switch = 0
endif

function! s:TmuxOrTmateExecutable()
  return (match($TMUX, 'tmate') != -1 ? 'tmate' : 'tmux')
endfunction

function! s:UseTmuxNavigatorMappings()
  return !get(g:, 'tmux_navigator_no_mappings', 0)
endfunction

function! s:InTmuxSession()
  return $TMUX != ''
endfunction

function! s:TmuxSocket()
  " The socket path is the first value in the comma-separated list of $TMUX.
  return split($TMUX, ',')[0]
endfunction

function! s:TmuxCommand(args)
  let cmd = s:TmuxOrTmateExecutable() . ' -S ' . s:TmuxSocket() . ' ' . a:args
  return system(cmd)
endfunction

function! s:TmuxPaneCurrentCommand()
  echo s:TmuxCommand("display-message -p '#{pane_current_command}'")
endfunction
command! TmuxPaneCurrentCommand call s:TmuxPaneCurrentCommand()

let s:tmux_is_last_pane = 0
augroup tmux_navigator
  au!
  autocmd WinEnter * let s:tmux_is_last_pane = 0
augroup END

" Like `wincmd` but also change tmux panes instead of vim windows when needed.
function! s:TmuxWinCmd(direction)
  if s:InTmuxSession()
    call s:TmuxAwareNavigate(a:direction)
  else
    call s:VimNavigate(a:direction)
  endif
endfunction

function! s:NeedsVitalityRedraw()
  return exists('g:loaded_vitality') && v:version < 704 && !has("patch481")
endfunction

function! s:TmuxAwareNavigate(direction)
  let nr = winnr()
  let tmux_last_pane = (a:direction == 'p' && s:tmux_is_last_pane)
  if !tmux_last_pane
    call s:VimNavigate(a:direction)
  endif
  " Forward the switch panes command to tmux if:
  " a) we're toggling between the last tmux pane;
  " b) we tried switching windows in vim but it didn't have effect.
  if tmux_last_pane || nr == winnr()
    if g:tmux_navigator_save_on_switch == 1
      try
        update " save the active buffer. See :help update
      catch /^Vim\%((\a\+)\)\=:E32/ " catches the no file name error 
      endtry
    elseif g:tmux_navigator_save_on_switch == 2
      try
        wall " save all the buffers. See :help wall
      catch /^Vim\%((\a\+)\)\=:E141/ " catches the no file name error 
      endtry
    endif
    let args = 'select-pane -t ' . shellescape($TMUX_PANE) . ' -' . tr(a:direction, 'phjkl', 'lLDUR')
    silent call s:TmuxCommand(args)
    if s:NeedsVitalityRedraw()
      redraw!
    endif
    let s:tmux_is_last_pane = 1
  else
    let s:tmux_is_last_pane = 0
  endif
endfunction

function! s:VimNavigate(direction)
  try
    execute 'wincmd ' . a:direction
  catch
    echohl ErrorMsg | echo 'E11: Invalid in command-line window; <CR> executes, CTRL-C quits: wincmd k' | echohl None
  endtry
endfunction

command! TmuxNavigateLeft call s:TmuxWinCmd('h')
command! TmuxNavigateDown call s:TmuxWinCmd('j')
command! TmuxNavigateUp call s:TmuxWinCmd('k')
command! TmuxNavigateRight call s:TmuxWinCmd('l')
command! TmuxNavigatePrevious call s:TmuxWinCmd('p')

if s:UseTmuxNavigatorMappings()
  nnoremap <silent> <c-h> :TmuxNavigateLeft<cr>
  nnoremap <silent> <c-j> :TmuxNavigateDown<cr>
  nnoremap <silent> <c-k> :TmuxNavigateUp<cr>
  nnoremap <silent> <c-l> :TmuxNavigateRight<cr>
  nnoremap <silent> <c-\> :TmuxNavigatePrevious<cr>
endif
"}}}

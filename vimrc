" Set up a better encoding
set encoding=utf-8

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin()

" Golang
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" Generic
Plug 'ervandew/supertab'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'

" Git
Plug 'tpope/vim-fugitive'

" Theming/Color
Plug 'vim-scripts/wombat256.vim'

" Hardmode.... Why not...?.... ;(
Plug 'takac/vim-hardtime'

" Return to last edit position
Plug 'farmergreg/vim-lastplace'

" Directory Tree
Plug 'scrooloose/nerdtree'

" Fancy Bar at the bottom of the screen
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
call plug#end()

set t_Co=256
colorscheme wombat256mod

" autocmd vimenter * if !argc() | NERDTree | endif
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" autoindent: Does not reset cursor to left of window.
set autoindent

" Buffer Related
set hidden

" expandtab: tabs make spaces, smarttab: better alignment
set expandtab
set smarttab

" shiftwidth: how many spaces tab will take up
" softtabstop: backspacing through spaces isn't hell
set shiftwidth=2
set softtabstop=2

" Set line numbers
set number

" Relative Numbers
set relativenumber

" airline settings
" Enable the list of buffers
" let g:airline#extensions#tabline#enabled = 1
" Show just the filename
" let g:airline#extensions#tabline#fnamemod = ':t'
" Set the airline theme
let g:airline_theme='wombat'

" Insert -> Normal ft. Dr Casey
inoremap jk <ESC>

" Leader
" let mapleader = "\<Space>"

" Quick editing of VimRC and Sourcing it too
nnoremap <leader>ev :edit $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>


" Hardmode Toggle
nnoremap <leader>h <Esc>:call HardTimeToggle()<CR>
let g:hardtime_default_on = 1

" Paste Mode
nnoremap <leader>p :set paste!<CR>

" Allow mouse interface, middle mouse doesn't work well.
" set mouse=a

" Uses appropriate syntax highlighting.
syntax on

" This shows what you are typing as a command.
set showcmd

" Remove any trailing whitespace that is in the file
autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif


" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
map N Nzz
map n nzz

" First let statement displays title as hostname[vim(Filename)]
" let &titlestring = hostname() . "[vim(" . expand("%:t") . ")]"
" Below let statement displays title as the filename being edited.

let &titlestring = expand("%:t")
if &term == "screen"
  set t_ts=^[k
  set t_fs=^[\
endif
if &term == "screen" || &term == "xterm-256color"
  set title
endif

" let paste_mode = 0 " 0 = normal, 1 = paste

" func! Paste_on_off()
"    if g:paste_mode == 0
"       set paste
"       let g:paste_mode = 1
"    else
"       set nopaste
"       let g:paste_mode = 0
"    endif
"    return
" endfunc

" Turn off arrow keys (this might not be a good idea for beginners, but it is
" " the best way to ween yourself of arrow keys on to hjkl)
" "
" http://yehudakatz.com/2010/07/29/everyone-who-tried-to-convince-me-to-use-vim-was-wrong/
" nnoremap <Left> :echoe "Use h"<CR>
" nnoremap <Right> :echoe "Use l"<CR>
" nnoremap <Up> :echoe "Use k"<CR>
" nnoremap <Down> :echoe "Use j"<CR>"
" inoremap <up> <nop>
" inoremap <down> <nop>
" inoremap <left> <nop>
" inoremap <right> <nop>

" check to make sure vim has been compiled with colorcolumn support
" " before enabling it
if exists("+colorcolumn")
  set colorcolumn=80
endif

" Number of spaces that a pre-existing tab is equal to.
" For the amount of space used for a new tab use shiftwidth.
au BufRead,BufNewFile *py,*pyw,*.c,*.h set tabstop=8

" What to use for an indent.
" This will affect Ctrl-T and 'autoindent'.
" Python: 4 spaces
" C: tabs (pre-existing files) or 4 spaces (new files)
au BufRead,BufNewFile *.py,*pyw set shiftwidth=4
au BufRead,BufNewFile *.py,*.pyw set expandtab
func! Select_c_style()
    if search('^\t', 'n', 150)
        set shiftwidth=8
        set noexpandtab
    el
        set shiftwidth=4
        set expandtab
    en
endf

" Python tabs
au BufRead,BufNewFile *.c,*.h call Select_c_style()
au BufRead,BufNewFile Makefile* set noexpandtab

" Use the below highlight group when displaying bad whitespace is desired.
highlight BadWhitespace ctermbg=red guibg=red

" Display tabs at the beginning of a line in Python mode as bad.
au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/
" Make trailing whitespace be flagged as bad.
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" Wrap text after a certain number of characters
" Python: 79
" C: 79
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h set textwidth=79

" Turn off settings in 'formatoptions' relating to comment formatting.
" - c : do not automatically insert the comment leader when wrapping based on
"    'textwidth'
" - o : do not insert the comment leader when using 'o' or 'O' from command mode
" - r : do not insert the comment leader when hitting <Enter> in insert mode
" Python: not needed
" C: prevents insertion of '*' at the beginning of every line in a comment
au BufRead,BufNewFile *.c,*.h set formatoptions-=c formatoptions-=o formatoptions-=r

" Use UNIX (\n) line endings.
" Only used for new files so as to not force existing files to change their
" line endings.
" Python: yes
" C: yes
au BufNewFile *.py,*.pyw,*.c,*.h set fileformat=unix

filetype plugin indent on
syntax on

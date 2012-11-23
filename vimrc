call pathogen#infect()
set t_Co=256
colorscheme wombat256mod

autocmd vimenter * if !argc() | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" autoindent: Does not reset cursor to left of window.
set autoindent

" expandtab: tabs make spaces, smarttab: better alignment
set expandtab
set smarttab

" shiftwidth: how many spaces tab will take up
" softtabstop: backspacing through spaces isn't hell
set shiftwidth=2
set softtabstop=2

" Set line numbers
set number

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

let paste_mode = 0 " 0 = normal, 1 = paste

func! Paste_on_off()
   if g:paste_mode == 0
      set paste
      let g:paste_mode = 1
   else
      set nopaste
      let g:paste_mode = 0
   endif
   return
endfunc

" Turn off arrow keys (this might not be a good idea for beginners, but it is
" " the best way to ween yourself of arrow keys on to hjkl)
" "
" http://yehudakatz.com/2010/07/29/everyone-who-tried-to-convince-me-to-use-vim-was-wrong/
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>"
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" check to make sure vim has been compiled with colorcolumn support
" " before enabling it
if exists("+colorcolumn")
  set colorcolumn=80
endif

filetype plugin indent on
syntax on

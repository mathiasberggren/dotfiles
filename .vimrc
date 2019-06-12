let $BASH_ENV="~/.bash_aliases"

syntax enable
colorscheme ron
set number

set tabstop=4
set softtabstop=4
set shiftwidth=4


" Disable all backup, avoiding swap files 
" set nobackup
" set nowb
" set noswapfile

" Visual mode pressing # searches for the current selection
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

" :split behaviour
set splitbelow
set splitright

" Move between :split windows with Ctrl + hjkl 
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" :W sudo saves the file 
command W w !sudo tee % > /dev/null

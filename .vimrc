" Enable bash aliases inside of vim  (:! alias)
let $BASH_ENV="~/.bash_aliases"

syntax enable
colorscheme ron
set number

" Tab = 4 spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4

" Disable all backup, avoiding swap files 
" set nobackup
" set nowb
" set noswapfile

" :split behaviour
set splitbelow
set splitright
" Ignore case when searching
set ignorecase
" Move between :split windows with Ctrl + hjkl 
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Ignore case when searching
set ignorecase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch 

" :W sudo saves the file 
command W w !sudo tee % > /dev/null

" Visual mode pressing # searches for the current selection
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

function! CmdLine(str)
    call feedkeys(":" . a:str)
endfunction 

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

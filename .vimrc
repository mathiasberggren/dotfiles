" Enable bash aliases inside of vim  (:! alias)
let $BASH_ENV="~/.bash_aliases"

" Set leader key to ,
let mapleader = ","

syntax enable
colorscheme ron
" Change default paranteses matching for ron colorscheme so they're not invisible
hi MatchParen ctermfg=Black ctermbg=238

" Make sure template files (*.tpp) for C++ has syntax highlightning
autocmd BufNewFile,BufRead *.tpp set syntax=cpp

" Add line numbers
set number

" Display current command
set showcmd

" Get same clipboard as system default = Enable copy between different VIM sessions
" Installed vim-gnome instead of rebinds
set clipboard=unnamedplus

" <leader>e reloads the buffer if changed
map <leader>e :bufdo e!<CR>

" Tab = 4 spaces
filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab
" Delete entire tab with spaces when pressing delete
set softtabstop=4

" For makefiles, don't use space as tab
au FileType make         setl noexpandtab sts=0 shiftwidth=0

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
nnoremap <C-h> <C-W>h
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-l> <C-W>l

" Move around split windows with Ctrl + HJKL
nnoremap <C-S-h> <C-W>H
nnoremap <C-S-j> <C-W>J
nnoremap <C-S-k> <C-W>K
nnoremap <C-S-l> <C-W>L  

" Ignore case when searching
set ignorecase

" Makes search act like search in modern browsers
set incsearch 

" :W sudo saves the file 
command W w !sudo tee % > /dev/null

" Highlight search results
set hlsearch

" Enter creates newline at cursor position and jumps back to prev position
" nnoremap <silent> <CR> i<CR><Esc>k$

" Turn of highlighted search results by pressing space key
nnoremap <silent> <Space> :noh<CR>

" Visual mode pressing <leader>s searches for the current selection
vnoremap <silent> <leader>s :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

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

" Affects cursor settings for all programs opened with gnome terminal.
au InsertEnter * silent execute "!echo -ne '\e[5 q'"
au InsertLeave * silent execute "!echo -ne '\e[2 q'"
au VimLeave * silent execute "!echo -ne '\e[2 q'"
au VimEnter * silent execute "!echo -ne '\e[2 q'"

" Comment out blocks of code
noremap <silent> <expr> <C-_> (synIDattr(synID(line("."), col("."), 0), "name") =~ 'comment\c') ?
\ ':<S-Left>exe "<S-Right>normal! ".b:unCommentCommand<CR>' :
\ ':<S-Left>exe "<S-Right>normal! ".b:commentCommand<CR>'

"Comment/Uncomment for C/C++, CUDA, java+script files
autocmd BufReadPost *.{c,cc,cpp,tpp,h,cu,java,js} let b:commentCommand='I// '
autocmd BufReadPost *.{c,cc,cpp,tpp,h,cu,java,js} let b:unCommentCommand='^xxx'
"Comment/Uncomment for bash and script files
autocmd BufReadPost {*rc,*.bash*} let b:commentCommand='I" '
autocmd BufReadPost {*rc,*.bash*} let b:unCommentCommand='^xx'
"Comment/Uncomment for python, ruby, perl files
autocmd BufReadPost *.{py,rb,pl} let b:commentCommand='I# '
autocmd BufReadPost *.{py,rb,pl} let b:unCommentCommand='^xx'

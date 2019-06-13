" Enable bash aliases inside of vim  (:! alias)
let $BASH_ENV="~/.bash_aliases"

syntax enable
colorscheme ron
" Change default paranteses matching for ron colorscheme so they're not invisible
hi MatchParen ctermfg=Black ctermbg=238
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

" Makes search act like search in modern browsers
set incsearch 

" :W sudo saves the file 
command W w !sudo tee % > /dev/null

" Highlight search results
set hlsearch

" Turn of highlighted search results by pressing esc key
nnoremap <silent> <Space> :noh<cr>

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

" Affects cursor settings for all programs opened with gnome terminal.
au InsertEnter * silent execute "!echo -ne '\e[5 q'"
au InsertLeave * silent execute "!echo -ne '\e[2 q'"
au VimLeave * silent execute "!echo -ne '\e[2 q'"
au VimEnter * silent execute "!echo -ne '\e[2 q'"

" Comment out blocks of code
noremap <silent> <expr> <C-_> (synIDattr(synID(line("."), col("."), 0), "name") =~ 'comment\c') ?
\ ':<S-Left>exe "<S-Right>normal! ".b:unCommentCommand<CR>' :
\ ':<S-Left>exe "<S-Right>normal! ".b:commentCommand<CR>'

"Comment/Uncomment for C/C++, java+script files
autocmd BufReadPost *.{c,cc,cpp,h,java,js} let b:commentCommand='I//'
autocmd BufReadPost *.{c,cc,cpp,h,java,js} let b:unCommentCommand='^xx'
"Comment/Uncomment for bash and script files
autocmd BufReadPost {*rc,*.bash*} let b:commentCommand='I"'
autocmd BufReadPost {*rc,*.bash*} let b:unCommentCommand='^x'
"Comment/Uncomment for python, ruby, perl files
autocmd BufReadPost *.{py,rb,pl} let b:commentCommand='I#'
autocmd BufReadPost *.{py,rb,pl} let b:unCommentCommand='^x'

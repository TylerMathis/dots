call plug#begin()

    Plug 'dracula/vim'
    Plug 'ryanoasis/vim-devicons'
    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'
    Plug 'scrooloose/nerdtree'
    Plug 'preservim/nerdcommenter'
    Plug 'mhinz/vim-startify'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'wakatime/vim-wakatime'

call plug#end()

" No vim compat
set nocompatible

" Paste and click
set mouse=v
set mouse=a
set clipboard=unnamedplus

" Searching
set showmatch
set ignorecase
set hlsearch
set incsearch

" Tabs
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
filetype plugin indent on
filetype plugin on

" Vis
syntax on
set number relativenumber
set wildmode=longest,list
set cc=80
set cursorline
set ttyfast

" Colors
if (has("termguicolors"))
    set termguicolors
endif
syntax enable
colorscheme dracula

" Splitpanes on right and below
set splitright
set splitbelow

" Simulate VSCode alt-up-down behavior
nnoremap <A-k> ddkkp
nnoremap <A-j> ddp

" Move between panes to left/bottom/top/right
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Press i to enter insert mode, and kj to exit insert mode.
inoremap jk <Esc>
inoremap kj <Esc>

" Easy refactoring
noremap <F2> <Plug>(coc-rename)

" Add matching brace
inoremap {<CR> {<CR>}<ESC>O

" Open file path in new pane with gf
nnoremap gf :vert winc f<CR>

" Copy current filepath to clipboard
nnoremap <silent> yf :let @+=expand('%:p')<CR>

" Toggle NERDTree
nnoremap <C-f> :NERDTreeToggle<CR>

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Use tab for trigger completion with characters ahead and navigate.
let g:UltiSnipsExpandTrigger="<Nop>"
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Jump to last used location when reopening a file
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" Strip trailing whitespace from lines when writing
function! StripTrailingWhitespace()
    normal mZ
    let l:chars = col("$")
    %s/\s\+$//e
    normal `Z
endfunction
autocmd BufWritePre * call StripTrailingWhitespace()

"
" COMPETITIVE PROGRAMMING
"

" Autoload C++ template
autocmd BufNewFile *.cpp -r ~/cp/progteam/templates/template.cpp

" F3 for input file swapping
noremap <F3> :call ToggleInputBuffer()<CR>
let g:last_cursor_position = [0, 0, 0, 0]
function! ToggleInputBuffer()
    let ext = expand("%:e")
    if (ext == 'in')
        w
        execute 'edit' expand("%:r") . ".cpp"
        call cursor(g:last_cursor_position[1], g:last_cursor_position[2])
    elseif (ext == 'cpp')
        let g:last_cursor_position = getpos(".")
        w
        e %:r.in
        norm! gg
    endif
endfunction

" Auto run/debug
noremap <F4> :w!<CR>:<C-u>!g++ -std=c++17 -O2 -Wall %:r.cpp &&
            \ ./a.out < %:r.in;
            \ rm a.out<CR>
noremap <F5> :w!<CR>:<C-u>!g++ -std=c++17 -O2 -Wall -g %:r.cpp &&
            \ valgrind ./a.out < %:r.in;
            \ rm a.out vgcore*<CR>

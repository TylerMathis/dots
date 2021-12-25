call plug#begin()

Plug 'morhetz/gruvbox'
Plug 'dracula/vim', {'as': 'dracula'}
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

set pyxversion=3

" coloring
syntax on
colorscheme dracula
noremap <c-n> :noh<CR>

" locative
set number
set relativenumber

noremap <c-i> :call ToggleInputBuffer()<CR>
let g:last_file_open = ''
let g:last_cursor_position = [0, 0, 0, 0]
function! ToggleInputBuffer()
    let file_name = expand('%:t')
    if (file_name == 'input.in')
        if (g:last_file_open != '')
            w
            execute 'edit' g:last_file_open
            call cursor(g:last_cursor_position[1], g:last_cursor_position[2])
        endif
    else
        let g:last_file_open = file_name
        let g:last_cursor_position = getpos(".")
        w
        e input.in
    endif
endfunction

" menu
set wildmenu
set pumheight=5

" searching
set hlsearch
set ignorecase
set smartcase
set incsearch

" spacing
filetype indent on
set so=5
set ai
set si
set cindent
set tabstop=4
set shiftwidth=4
set softtabstop=0
set expandtab
set smarttab
set pastetoggle=<f1>
set listchars=tab:\|\ ,trail:_ list
cal matchadd('ColorColumn', '\%81v.', 100)
noremap <c-f> :call FormatFullFile()<CR>

function! FormatFullFile()
    let g:last_cursor_position = getpos(".")
    normal gg=G
    call cursor(g:last_cursor_position[1], g:last_cursor_position[2])
endfunction

function! StripTrailingWhitespace()
    normal mZ
    let l:chars = col("$")
    %s/\s\+$//e
    normal `Z
endfunction

autocmd BufWritePre * call StripTrailingWhitespace()

" speed
inoremap kj <ESC>
nmap <F2> <Plug>(coc-rename)

" syntactical
set showmatch
set matchpairs+=<:>
let c_no_curly_error=1
inoremap {<CR> {<CR>}<ESC>O

" template (add for each file type and extension)
autocmd BufNewFile *.cpp -r ~/progteam/templates/template.cpp

" test
noremap <F5> :w!<CR>:<C-u>!g++ -std=c++17 -O2 -Wall %:r.cpp &&
            \ ./a.out < input.in<CR>

" debug
noremap <F6> :w!<CR>:<C-u>!g++ -std=c++17 -O2 -Wall -g %:r.cpp &&
            \ valgrind ./a.out < input.in;
            \ rm vgcore*<CR>

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If youre using tmux version 2.2 or later, you can remove the outermost check and use tmuxs 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif


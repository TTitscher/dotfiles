set nocompatible              " be iMproved, required

" Plugins
" --------
filetype off
call plug#begin('~/.config/nvim/plugged')
" Auto-complete
Plug 'Valloric/YouCompleteMe', {'do': './install.py --clang-completer' }
" Clang format
Plug 'rhysd/vim-clang-format'
" CTRLP - fuzzy file finder
Plug 'ctrlpvim/ctrlp.vim'
" Nice status line
Plug 'bling/vim-airline'
" color scheme
Plug 'romainl/flattened'
Plug 'morhetz/gruvbox'
Plug 'NLKNguyen/papercolor-theme'
Plug 'joshdick/onedark.vim'
" nerdtree
Plug 'scrooloose/nerdtree'
" nerdcommenter
Plug 'scrooloose/nerdcommenter'
call plug#end()
filetype plugin indent on

" Appearance
" ----------
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_section_x = ''
let g:airline_section_y = ''
let g:airline_section_error = '' 
let g:airline_section_warning = ''
syntax on
set termguicolors
colorscheme onedark

"show line limit
set cc=80

" Different cursor shape depending on mode
:let $nvim_tui_enable_cursor_shape=1

" general
" -------
" leave 10 lines at top & bottom while scrolling
set scrolloff=10
set sidescrolloff=5
" indentation
set autoindent
set smarttab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

set relativenumber
set number
set ttimeout
set ttimeoutlen=100

" return to last edit position when opening files (you want this!)
autocmd bufreadpost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif


set incsearch
set ignorecase
set smartcase
" write ~ and .swp wiles to tmp directory
set backupdir=~/.config/nvim/tmp,.
set directory=~/.config/nvim/tmp,.

set undofile
set undodir=~/.config/nvim/tmp


" let g:ycm_confirm_extra_conf = 0
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_global_ycm_extra_conf = ''
let g:ycm_confirm_extra_conf=0
let g:ycm_complete_in_comments=1

let g:clang_format#auto_format_on_insert_leave = 1
let g:clang_format#detect_style_file = 1

let g:ctrlp_custom_ignore = '\v[\/](build|release|build_gcc)$'


" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
inoremap <esc> <nop>
inoremap jk <esc>

nmap <m-i> :ClangFormat<CR>
" add m-j to jump , m-k to jump back
nmap <m-j> :YcmCompleter GoTo<CR>
nmap <m-k> <c-o>
nmap <m-t> :YcmCompleter GetType<CR>
nmap <m-f> :YcmCompleter FixIt<CR>

let g:DoxygenToolkit_commentType = "C++"
let g:DoxygenToolkit_compactDoc = "yes"
let g:DoxygenToolkit_templateParamTag_pre="pre"
let g:DoxygenToolkit_templateParamTag_post="post"


map <c-n> :NERDTreeToggle<CR>
nmap <m-d> <Plug>NERDCommenterToggle
vmap <m-d> <Plug>NERDCommenterToggle

nmap <leader>br O//! @brief 
nmap <leader>par o! @param 
nmap <leader>ret o! @return 

nmap qq :q!<CR>

:set makeprg=python\ %

function! QuickBuild()
    if &filetype == "cpp"
        !clang++ -std=c++14 % && ./a.out
    endif
    if &filetype == "python"
        !python %
    endif
    if &filetype == "tex"
        !latexmk -xelatex -bibtex  %
    endif
endfunction

" fast build && run
nmap <m-b> :w \| :call QuickBuild() <CR>

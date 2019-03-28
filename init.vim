set nocompatible              " be iMproved, required

" Plugins
" --------
filetype off
call plug#begin('~/.config/nvim/plugged')
"
" General stuff
" =============
"
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
" Nice status line
Plug 'bling/vim-airline'
" color scheme
Plug 'romainl/flattened'
Plug 'joshdick/onedark.vim'
" nerdtree
Plug 'scrooloose/nerdtree'
" nerdcommenter
Plug 'scrooloose/nerdcommenter'
" expand region
Plug 'terryma/vim-expand-region'
" snippets engine triggered by YCM
Plug 'SirVer/ultisnips'
" actual snippets
Plug 'honza/vim-snippets'
" supertab somehow for ycm and snippets to work together
Plug 'ervandew/supertab'
"
" mainly cpp stuff
" ================
"
" Auto-complete
Plug 'Valloric/YouCompleteMe', {'do': './install.py --clang-completer' }
" Clang format
Plug 'rhysd/vim-clang-format'
" ycm generator from cmake project
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}
" cpp enhanced highlighting for own methods/templates
Plug 'octol/vim-cpp-enhanced-highlight'
"
" Python stuff
" ============
"
Plug 'vim-syntastic/syntastic'
Plug 'ambv/black'
"
" other stuff
" ===========
"
" auto parentheses
Plug 'jiangmiao/auto-pairs'
" some latex support
Plug 'lervag/vimtex'
" Tagbar (!!!) To make this work properly with latex, recompile the
" newest version of ctags from source:
" $ autoheader
" $ autoconf  // both in package (apt-get install autoconf)
" $ ./configure
" $ make
" $ sudo make install
Plug 'majutsushi/tagbar'
" gmsh syntax
Plug 'vim-scripts/gmsh.vim'
" Markdown
Plug 'plasticboy/vim-markdown'
" advanced folding
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
set termguicolors

"default colorscheme
colorscheme onedark

augroup filetypedetect
au BufNewFile,BufRead *.i     setf cpp
au BufNewFile,BufRead *.geo   setf gmsh
au BufNewFile,BufRead *.tikz  setf tex
au FileType python setlocal formatprg=autopep8\ -
augroup END


"show line limit
set cc=80

" Different cursor shape depending on mode
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

" general
" -------
" leave 10 lines at top & bottom while scrolling
set scrolloff=10
set sidescrolloff=5
set mouse=a
" indentation
set foldlevelstart=99
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
set linebreak

autocmd FileType tex setlocal shiftwidth=2 tabstop=2

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

" autosave before ':make'
set autowrite

set inccommand=split

let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_global_ycm_extra_conf = ''
let g:ycm_complete_in_comments = 1
let g:ycm_confirm_extra_conf=0

" YouCompleteMe and UltiSnips compatibility, with the helper of supertab
" (via http://stackoverflow.com/a/22253548/1626737)
let g:SuperTabDefaultCompletionType    = '<C-n>'
let g:SuperTabCrMapping                = 0
let g:UltiSnipsExpandTrigger           = '<tab>'
let g:UltiSnipsJumpForwardTrigger      = '<tab>'
let g:UltiSnipsJumpBackwardTrigger     = '<s-tab>'
let g:ycm_key_list_select_completion   = ['<C-j>', '<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-k>', '<C-p>', '<Up>']

let g:clang_format#auto_format_on_insert_leave = 0
let g:clang_format#auto_format = 1
let g:clang_format#detect_style_file = 1

let g:cpp_experimental_template_highlight = 1
let g:cpp_concepts_highlight = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1


let g:vimtex_latexmk_options="-lualatex -synctex=1 --shell-escape"
let g:vimtex_quickfix_mode=0
let g:vimtex_view_method="zathura"
let g:tex_flavor='latex'
"set conceallevel=1
"let g:tex_conceal="abdmg"


let g:python_highlight_all = 1

" search for files up to $HOME
set path=.;$HOME

" define leader SPACE
let mapleader = "\<Space>"
let maplocalleader = "\<Space>"

" try hardmode:
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
inoremap jk <esc>
vnoremap jk <esc>
cnoremap jk <C-c>

" gj is like j but on wrapped lines, nice
noremap j gj
noremap k gk

nnoremap <Leader>o :Files~<CR>
nnoremap <Leader>p :Files<CR>


"Enter visual line mode with <Space><Space>:
nmap <Leader><Leader> V

" some general hotkeys
" ====================
" clear highlighted search
map <F3> :nohlsearch<CR>

map <c-n> :NERDTreeToggle<CR>
nmap <m-d> <Plug>NERDCommenterToggle
vmap <m-d> <Plug>NERDCommenterToggle

" search / replace symbol under curser for the whole document
:nnoremap <Leader>s :%s/\<<C-r><C-w>\>//g<Left><Left>

vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

nmap <F10> :TagbarToggle<CR>

" c++ specific hotkeys
" ====================
" add m-j to jump , m-k to jump back
nmap <m-j> :YcmCompleter GoTo<CR>
nmap <m-k> <c-o>
nmap <m-t> :YcmCompleter GetType<CR>
nmap <m-f> :YcmCompleter FixIt<CR>

" Go to header/cpp file
nmap gc :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>
" Find implementation:
" yank inner word
" open cpp-file
" search for ::+word
nmap gd yiw :e %<.cpp<CR> :/\:\:<c-r>"<cr>:noh<cr>

function! QuickBuild()
    if &filetype == "cpp"
        !clang++ -std=c++14 -pthread % && ./a.out
    endif
    if &filetype == "python"
        !python3 %
    endif
    if &filetype == "markdown"
        !pandoc % --standalone --toc --mathjax --css ~/dotfiles/github.css -o %<.html
        " then open the html file in a browser, possibly with autorefresh
        " plugin
    endif
endfunction

" fast build && run
nmap <m-b> :w \| :call QuickBuild() <CR>


" Markdown
" ========
let g:vim_markdown_math = 1
let g:vim_markdown_folding_disabled = 1

syntax on

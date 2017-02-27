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
" Nice status line
Plug 'bling/vim-airline'
" color scheme
Plug 'romainl/flattened'
Plug 'morhetz/gruvbox'
Plug 'NLKNguyen/papercolor-theme'
Plug 'joshdick/onedark.vim'
Plug 'endel/vim-github-colorscheme'
Plug 'vim-scripts/Simple256'
" nerdtree
Plug 'scrooloose/nerdtree'
" nerdcommenter
Plug 'scrooloose/nerdcommenter'
" expand region
Plug 'terryma/vim-expand-region'

"
" mainly cpp stuff
" ================
" 
" Auto-complete
Plug 'Valloric/YouCompleteMe', {'do': './install.py --clang-completer' }
" snippets engine triggered by YCM
Plug 'SirVer/ultisnips'
" actual snippets
Plug 'honza/vim-snippets'
" supertab somehow for ycm and snippets to work together
Plug 'ervandew/supertab'
" Clang format
Plug 'rhysd/vim-clang-format'
" ycm generator from cmake project
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}
" rtags indexer
Plug 'lyuts/vim-rtags'
" 
" other stuff
" ===========
" 
" auto parentheses
Plug 'jiangmiao/auto-pairs'
" some latex support
Plug 'lervag/vimtex'
" cpp enhanced highlighting for own methods/templates
Plug 'octol/vim-cpp-enhanced-highlight'
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
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
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

"different colorscheme for latex and markdown
"autocmd FileType tex colorscheme flattened_light
"autocmd FileType markdown colorscheme flattened_light

" GMSH (Meshing Facilities) 
augroup filetypedetect 
au BufNewFile,BufRead *.geo     setf gmsh 
augroup END 

"show line limit
"set cc=80

" Different cursor shape depending on mode
:let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

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

" autosave before ':make'
set autowrite

let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_global_ycm_extra_conf = ''
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

let g:clang_format#auto_format_on_insert_leave = 1
let g:clang_format#detect_style_file = 1



let g:cpp_experimental_template_highlight = 1
let g:cpp_concepts_highlight = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1


let g:vimtex_latexmk_options="-xelatex -bibtex"


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
inoremap <esc> <nop>
inoremap jk <esc>
vnoremap jk <esc>


nnoremap <Leader>o :Files~<CR>
"nnoremap <Leader>w :w<CR>



"Enter visual line mode with <Space><Space>:
nmap <Leader><Leader> V

" some general hotkeys
" ====================
nmap qq :q!<CR>
" clear highlighted search
map <F3> :nohlsearch<CR>

map <c-n> :NERDTreeToggle<CR>
nmap <m-d> <Plug>NERDCommenterToggle
vmap <m-d> <Plug>NERDCommenterToggle
"nmap <Leader>d <Plug>NERDCommenterToggle
"vmap <Leader>d <Plug>NERDCommenterToggle

" search / replace symbol under curser for the whole document
:nnoremap <Leader>s :%s/\<<C-r><C-w>\>//g<Left><Left>

vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)




nmap <F10> :TagbarToggle<CR>

" c++ specific hotkeys
" ====================
nmap <m-i> :ClangFormat<CR>
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


" doxygen:
nmap <leader>br O//! @brief 
nmap <leader>par o! @param 
nmap <leader>ret o! @return 


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

" cursor must be the beginning of the method name!
function! ExtractDefinition()
    normal ma
    " yank possible return value from 0 to a
    normal 0"ay`a
    let s:returnType = @a
    let s:returnType = substitute(s:returnType, "\<virtual\>", "", "")
    let s:returnType = substitute(s:returnType, "\<static\>", "", "")

    " yank signature from a to ';'
    normal `a"ay/;
    let s:signature = @a
    let s:signature = substitute(s:signature, "\<override\>", "", "")
    " remove default arguments, naive approach: remove =...,
    let s:signature = substitute(s:signature, "\=.*,", "", "")
    " ... and everything from = ... )
    let s:signature = substitute(s:signature, "\=.*)", ")", "")
    
    
    echo s:signature
    " move cursor to previous word 'class' - backwards 'b'
    call search('\<class\>', 'b')
    normal w"ayw
    " yank the next word
    let s:className = @a
    " extract namespace
    let s:namespace = ''
    if search('\<namespace\>','b')
        normal w"ayw
        let s:namespace = @a
    endif
    " perfect user experience: cursor back to the start!
    normal `a
endfunction



function! InsertDefinition()
    " handle empty signature
    if empty(s:signature)
        echo "No signature found. Run ExtractDefinition() first."
    endif
    " handle empty namespace
    let l:printNamespace = ''
    if !empty(s:namespace)
        let l:printNamespace = s:namespace . '::'
    endif
    " write everything in one command and let clang do the formatting 
    exe 'normal o' s:returnType ' ' l:printNamespace s:className '::' s:signature '{}'
endfunction

nmap <M-w> :call ExtractDefinition()<CR>
nmap <M-e> :call InsertDefinition()<CR>jo


function! WriteToChatFile()
    let s:line = getline('.')
    let s:date = system('date +%T')
    let s:color = "\e[32m"
    let s:nocolor = "\e[0m"
    let s:user = " - ttitsche: "
    let s:output = s:color . s:date . s:user . s:nocolor  . s:line
    call writefile([s:output], 'chat.txt', "a")
    normal dd
    execute "start"
endfunction

map gl :call WriteToChatFile()<CR>



syntax on

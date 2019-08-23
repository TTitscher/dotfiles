if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins
" --------
filetype off
call plug#begin()
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

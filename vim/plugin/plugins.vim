call plug#begin('~/.vim/plugged')
" Addons
Plug 'scrooloose/nerdtree'
" Plug 'yegappan/mru'
Plug 'airblade/vim-gitgutter'
Plug 'ervandew/supertab'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-surround'
Plug 'tmhedberg/matchit'
Plug 'kana/vim-textobj-user'
Plug 'bps/vim-textobj-python'
Plug 'vim-scripts/tComment'
Plug 'jremmen/vim-ripgrep'
Plug 'blarghmatey/split-expander'
Plug 'farmergreg/vim-lastplace'
" Plug 'nathanaelkane/vim-indent-guides'
" Plug 'python-mode/python-mode'
Plug 'python-rope/rope'
Plug 'python-rope/ropemode'
Plug 'python-rope/ropevim'
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
Plug 'raimondi/delimitmate'
Plug 'yggdroot/indentline'

" Goto previous or next indentation level
Plug 'jeetsukumaran/vim-indentwise'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" Find files easily on project
Plug 'kana/vim-exjumplist'
Plug 'vimlab/split-term.vim'

" Tmux integration
Plug 'benmills/vimux'
Plug 'christoomey/vim-tmux-navigator'

" Plug 'epeli/slimux'
Plug 'jpalardy/vim-slime'
Plug 'itchyny/lightline.vim'
Plug 'kien/rainbow_parentheses.vim'

" File system navigation
Plug 'tpope/vim-eunuch'
Plug 'kien/ctrlp.vim'

" Syntax highlighting
Plug 'tpope/vim-endwise'
Plug 'elzr/vim-json'
Plug 'tpope/vim-markdown'
" Plug 'kchmck/vim-coffee-script'
Plug 'groenewege/vim-less'
" Plug 'tpope/vim-haml'
" Plug 'jparise/vim-graphql'
" Plug 'zerowidth/vim-copy-as-rtf'
" Plug 'Quramy/tsuquyomi'
" Plug 'leafgarland/typescript-vim'
" Plug 'Shougo/vimproc.vim'


" Syntax errors
Plug 'w0rp/ale'
"Plug 'ntpeters/vim-better-whitespace'
                    
" Markdown support
Plug 'junegunn/goyo.vim'

" Git support
Plug 'tpope/vim-fugitive', { 'commit': '444ba9fda5d05aa14c7e8664fa4a66a59c62a550' }

" Syntax checker
" Plug 'scrooloose/syntastic'
Plug 'ycm-core/YouCompleteMe'


" Editor config
Plug 'editorconfig/editorconfig-vim'

" Maximizer
Plug 'szw/vim-maximizer'


" Themes
" Plug 'altercation/vim-colors-solarized'
" Plug 'icymind/NeoSolarized'
Plug 'flazz/vim-colorschemes'
Plug 'arcticicestudio/nord-vim'

" Testing
Plug 'janko-m/vim-test'

" Display hex colors
Plug 'chrisbra/Colorizer'

" Gist
Plug 'mattn/webapi-vim' | Plug 'mattn/gist-vim'

call plug#end()

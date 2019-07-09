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
Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'vim-scripts/tComment'
Plug 'jremmen/vim-ripgrep'
Plug 'blarghmatey/split-expander'
Plug 'farmergreg/vim-lastplace'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'python-mode/python-mode'
Plug 'raimondi/delimitmate'


Plug 'francoiscabrol/ranger.vim'


Plug 'epeli/slimux'
Plug 'itchyny/lightline.vim'
Plug 'kien/rainbow_parentheses.vim'

" Tmux integration
Plug 'benmills/vimux'
Plug 'christoomey/vim-tmux-navigator'

" File system navigation
Plug 'tpope/vim-eunuch'
Plug 'kien/ctrlp.vim'

" Syntax highlighting
Plug 'tpope/vim-endwise'
Plug 'elzr/vim-json'
Plug 'tpope/vim-markdown'
Plug 'kchmck/vim-coffee-script'
Plug 'groenewege/vim-less'
Plug 'tpope/vim-haml'
Plug 'jparise/vim-graphql'
" Plug 'zerowidth/vim-copy-as-rtf'

" Syntax errors
Plug 'w0rp/ale'
"Plug 'ntpeters/vim-better-whitespace'
                    
" Markdown support
Plug 'junegunn/goyo.vim'

" Git support
Plug 'tpope/vim-fugitive', { 'commit': '444ba9fda5d05aa14c7e8664fa4a66a59c62a550' }

" Themes
" Plug 'altercation/vim-colors-solarized'
" Plug 'icymind/NeoSolarized'
Plug 'flazz/vim-colorschemes'

" Testing
Plug 'janko-m/vim-test'

" Display hex colors
Plug 'chrisbra/Colorizer'

" Gist
Plug 'mattn/webapi-vim' | Plug 'mattn/gist-vim'

call plug#end()

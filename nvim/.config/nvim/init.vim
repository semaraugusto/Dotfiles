set path+=**
" Nice menu when typing `:find *.py`
set wildmode=longest,list,full
set wildmenu
" Ignore files
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=**/coverage/*
" set wildignore+=**/node_modules/*
set wildignore+=**/.git/*


call plug#begin('~/.vim/plugged')

" Yes, I am a sneaky snek now
Plug 'ambv/black'

" Plebvim lsp Plugins
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-cmdline'
Plug 'tzachar/cmp-tabnine', { 'do': './install.sh' }
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'simrat39/rust-tools.nvim'

Plug 'norcalli/nvim-colorizer.lua'
Plug 'rcarriga/nvim-notify'
Plug 'tjdevries/nlua.nvim'
Plug 'tjdevries/colorbuddy.vim'
Plug 'tjdevries/gruvbuddy.nvim'
Plug 'jose-elias-alvarez/nvim-lsp-ts-utils'
Plug 'markwoodhall/vim-codelens'
Plug 'ericpubu/lsp_codelens_extensions.nvim' 
Plug 'tjdevries/vimterface.nvim'
Plug 'nvim-telescope/telescope-fzf-writer.nvim'
Plug 'AckslD/nvim-neoclip.lua'

Plug 'guns/vim-sexp'
Plug 'tpope/vim-sexp-mappings-for-regular-people'
" Plug 'nvim-lua/completion-nvim'
Plug 'euclidianAce/BetterLua.vim'
Plug 'tjdevries/vim9jit' 


" Plug 'neovim/nvim-lspconfig'
" Plug 'hrsh7th/cmp-nvim-lsp'
" Plug 'hrsh7th/cmp-buffer'
" Plug 'hrsh7th/nvim-cmp'

" Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'github/copilot.vim'


Plug 'onsails/lspkind-nvim'
" Plug 'github/copilot.vim'
Plug 'nvim-lua/lsp_extensions.nvim'

" Plug 'nvim-lua/completion-nvim'
Plug 'glepnir/lspsaga.nvim'
Plug 'simrat39/symbols-outline.nvim'
" Plug 'tjdevries/lsp_extensions.nvim'

" Neovim Tree shitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'

" Debugger Plugins
Plug 'theHamsta/nvim-dap-virtual-text'
Plug 'rcarriga/nvim-dap-ui'
Plug 'mfussenegger/nvim-dap-python'
Plug 'mfussenegger/nvim-dap'
Plug 'Pocco81/DAPInstall.nvim'
Plug 'szw/vim-maximizer'

" Snippets
"
" Plug 'SirVer/ultisnips'
Plug 'L3MON4D3/LuaSnip'
Plug 'rafamadriz/friendly-snippets'

Plug 'vim-scripts/tComment'
Plug 'kana/vim-exjumplist'
Plug 'rust-lang/rust.vim'
Plug 'mhinz/vim-crates' "Crates autocompletion/checking for latest versions
Plug 'iden3/vim-circom-syntax'
Plug 'darrikonn/vim-gofmt'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'junegunn/gv.vim'
Plug 'vim-utils/vim-man'
Plug 'mbbill/undotree'
Plug 'tpope/vim-dispatch'
Plug 'gruvbox-community/gruvbox'
Plug 'tpope/vim-projectionist'
Plug 'tomlion/vim-solidity'

" Coloring matching delimiters
Plug 'kien/rainbow_parentheses.vim'

" telescope requirements...
Plug 'tami5/sqlite.lua'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-hop.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'nvim-telescope/telescope-media-files.nvim'
Plug 'nvim-telescope/telescope-dap.nvim'
Plug 'nvim-telescope/telescope-file-browser.nvim' 
Plug 'nvim-telescope/telescope-frecency.nvim' 

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'flazz/vim-colorschemes'

" " HARPOON!!
" Plug 'mhinz/vim-rfc'
" Plug 'ThePrimeagen/harpoon'

Plug 'ThePrimeagen/git-worktree.nvim'
Plug 'ThePrimeagen/refactoring.nvim'

" prettier
Plug 'sbdchd/neoformat'
Plug 'maksimr/vim-jsbeautify'

" should I try another status bar???
"  Plug 'glepnir/galaxyline.nvim' , {'branch': 'main'}
Plug 'vim-airline/vim-airline'
" Plug 'hoob3rt/lualine.nvim'

call plug#end()

" lua require("lsp")
lua require("codelens_extensions").setup()

let mapleader=','
" status line

" Automatically run :CratesToggle when opening a Cargo.toml file:
if has('nvim')
  autocmd BufRead Cargo.toml call crates#toggle()
endif

" Buffer navigation
nmap gb <Plug>(exjumplist-previous-buffer) 
nmap gn <Plug>(exjumplist-next-buffer) 

" Prettier
map gpp :call JsonBeautify()

" Find files using Telescope command-line sugar.
" nnoremap <leader>ff <cmd>Files<CR>
" nnoremap <leader>fa <cmd>Telescope find_files<CR>
" nnoremap <leader>fg <cmd>Telescope live_grep<CR>
" nnoremap <leader>fb <cmd>Telescope buffers<CR>
" nnoremap <leader>fh <cmd>Telescope help_tags<CR>

" Maximizer
nnoremap <C-x><C-f> :MaximizerToggle<CR>

" Easy window navigation
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

imap <leader>gau auto,e
" Copy remaps
nnoremap <leader>y "+y
vnoremap <leader>y "+y
vnoremap <leader>p "+p
nnoremap <leader>p "+p
nnoremap <leader>Y gg"+yG
nnoremap <leader><leader>s <cmd>source ~/.config/nvim/after/plugin/luasnip.lua<CR>

" Delete remaps
nnoremap <leader>d "_d
vnoremap <leader>d "_d

" Undotree
nnoremap <leader>u :UndotreeShow<CR>

nnoremap <esc> :noh<return><esc>

syntax enable
filetype plugin on
filetype plugin indent on

syntax on

set title
set autoread                          " Auto reload changed files
set wildmenu                          " Tab autocomplete in command mode
set backspace=indent,eol,start        " http://vi.stackexchange.com/a/2163
set laststatus=2                      " Show status line on startup
set splitright                        " Open new splits to the right
set splitbelow                        " Open new splits to the bottom
"set lazyredraw                        " Reduce the redraw frequency
set ttyfast                           " Send more characters in fast terminals
"set nowrap                            " Don't wrap long lines
set noerrorbells novisualbell         " Turn off visual and audible bells
set expandtab shiftwidth=4 tabstop=4  " Four spaces for tabs everywhere
set smarttab
set history=1000
set hlsearch                          " Highlight search results
set ignorecase smartcase              " Search queries intelligently set case
set incsearch                         " Show search results as you type
set timeoutlen=1000 ttimeoutlen=0     " Remove timeout when hitting escape
set showcmd                           " Show size of visual selection

" Persistent undo
set undodir=~/.vim/undo/
set undofile
set undolevels=1000
set undoreload=10000

set number            " Enable line numbers
set mouse=a

let g:rustfmt_autosave = 1
" let g:snippets = "luasnip"

nnoremap <silent> <C-S-Up>      :m .-2<CR>==
nnoremap <silent> <C-S-Down>    :m .+1<CR>==
inoremap <silent> <C-S-Up>      <Esc>:m .-2<CR>==gi
inoremap <silent> <C-S-Down>    <Esc>:m .+1<CR>==gi
vnoremap <silent> <C-S-Up>      :m '>-2<CR>gv=gv
vnoremap <silent> <C-S-Down>    :m '<+1<CR>gv=gv

colorscheme gruvbox
set termguicolors
set background=dark


lua require("globals")
" lua require("lsp")
" lua require("telescope.start")
lua require("telescope_config")
lua require("lsp.dap")
lua require("telescope_config.setup")
lua require("telescope_config.mappings")
" lua require("snips")
" lua <<EOF
" for _, ft_path in ipairs(vim.api.nvim_get_runtime_file("lua/snips/ft/*.lua", true)) do
"   loadfile(ft_path)()
" end
" EOF

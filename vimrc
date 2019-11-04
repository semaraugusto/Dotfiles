" Settings in this file may depend on plugins, so let's install them first.
" Not to be confused with the contents of ~/.vim/plugin/* which are
" configuration options for each plugin and automatically loaded by Vim.
source ~/.vim/plugin/plugins.vim
let mapleader=','

let g:indent_guides_enable_on_vim_startup=1
let g:pymode_python = 'python3'
let g:pymode_trim_whitespaces = 1
let g:pymode_options = 1
let g:pymode_folding=0
let g:pymode_doc = 1
let g:pymode_doc = 1
let g:pymode_lint_ignore = ["E501", ]
set completeopt=menuone,noinsert
let g:pymode_rope_completion = 1
let g:pymode_rope_complete_on_dot = 1
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_builtin_types = g:pymode_syntax_all
let g:pymode_syntax_highlight_exceptions = g:pymode_syntax_all

let g:slime_python_ipython = 1
" let g:slime_target = "neovim"
" let g:slime_target = "tmux"
" let g:slime_default_config = {"socket_name": "default", "target_pane": "{right-of}"}
" set term=screen-256color
map <C-o> :NERDTreeToggle<CR>

" begin vim with vim -S and make it reopen last closed session
nnoremap <leader>s :mksession!<CR>

" let g:ycm_python_interpreter_path = '/home/semar/.pyenv/shims/python'
let g:ycm_python_interpreter_path = ''
let g:ycm_python_sys_path = []
let g:ycm_extra_conf_vim_data = [
  \  'g:ycm_python_interpreter_path',
  \  'g:ycm_python_sys_path'
  \]
let g:ycm_global_ycm_extra_conf = '~/global_extra_conf.py'
nmap <leader>gt :YcmCompleter GoTo<CR>
" nmap <leader>gd :YcmCompleter GoToDefinition<CR>
nmap g] :exec("YcmCompleter GoToDefinitionElseDeclaration")<CR>
nmap <leader>g] :vsp <CR>:exec("YcmCompleter GoToDefinitionElseDeclaration")<CR>
nmap <leader>g} :tabnew <CR>:exec("YcmCompleter GoToDefinitionElseDeclaration")<CR>


let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }
let g:fzf_command_prefix = 'Fzf'
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-buffer-line)
nnoremap <silent> <leader>f :FzfFiles<CR>
nnoremap <silent> <leader>F :FzfFiles!<CR>
nnoremap <silent> <leader>b  :FzfBuffers<CR>
nnoremap <silent> <leader>l :FzfBLines<CR>
nnoremap <silent> <leader>`  :FzfMarks<CR>
nnoremap <silent> <leader>p :FzfCommands<CR>
nnoremap <silent> <leader>t :FzfFiletypes<CR>
nnoremap <silent> <F1> :FzfHelptags<CR>
inoremap <silent> <F1> <ESC>:FzfHelptags<CR>
cnoremap <silent> <C-_> <C-u>:FzfCommands<CR>
let g:fzf_history_dir = '~/.local/share/fzf-history'

nmap gb <Plug>(exjumplist-previous-buffer) 
nmap gn <Plug>(exjumplist-next-buffer) 
map <leader>bd :Bclose<cr>

nmap          <C-W>+     <C-W>+<SID>ws
nmap          <C-W>-     <C-W>-<SID>ws
nn <script>   <SID>ws+   <C-W>+<SID>ws
nn <script>   <SID>ws-   <C-W>-<SID>ws
nmap          <C-W>>     <C-W>><SID>ws
nmap          <C-W><     <C-W><<SID>ws
nn <script>   <SID>ws>   <C-W>><SID>ws
nn <script>   <SID>ws<   <C-W><<SID>ws
nmap          <SID>ws    <Nop> 

map <Leader>w :w<CR>
map <Leader>q :qall<CR>
map <Leader>gs :Gstatus<CR>

nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)
nnoremap <leader>G :call FzfJumpDef('go')<CR>

set hidden

" Clear highlighting on escape in normal mode
nnoremap <esc> :noh<return><esc>
nnoremap <esc>^[ <esc>^[

filetype plugin on

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
set listchars=extends:→               " Show arrow if line continues rightwards
set listchars+=precedes:←             " Show arrow if line continues leftwards
set nobackup nowritebackup noswapfile " Turn off backup files
set noerrorbells novisualbell         " Turn off visual and audible bells
set expandtab shiftwidth=4 tabstop=4  " Four spaces for tabs everywhere
set smarttab
set history=500
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

" Ignored files/directories from autocomplete (and CtrlP)
set wildignore+=*/tmp/*
set wildignore+=*.so
set wildignore+=*.zip
set wildignore+=*/vendor/bundle/*
set wildignore+=*/node_modules/

"-------------------------------------------------------------------------------
" Interface
"-------------------------------------------------------------------------------

set number            " Enable line numbers
set relativenumber
set scrolloff=5       " Leave 5 lines of buffer when scrolling
set sidescrolloff=10  " Leave 10 characters of horizontal buffer when scrolling


" Move lines
nnoremap <silent> <C-S-Up>      :m .-2<CR>==
nnoremap <silent> <C-S-Down>    :m .+1<CR>==
inoremap <silent> <C-S-Up>      <Esc>:m .-2<CR>==gi
inoremap <silent> <C-S-Down>    <Esc>:m .+1<CR>==gi
vnoremap <silent> <C-S-Up>      :m '>-2<CR>gv=gv
vnoremap <silent> <C-S-Down>    :m '<+1<CR>gv=gv

"-------------------------------------------------------------------------------
" Colors & Formatting
"-------------------------------------------------------------------------------

" set background=light

" Showcase comments in italics
" highlight Comment cterm=italic gui=italic

"-------------------------------------------------------------------------------
" Neovim-specific configurations
"-------------------------------------------------------------------------------
colorscheme nord
set background=dark
" set termguicolors
" colorscheme gruvbox
if has('nvim')
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  set termguicolors
  " colorscheme NeoSolarized
  set background=dark

  " Fix vim-tmux-navigator <C-h> https://git.io/viGRU
  nmap <BS> <C-W>h

  " Fix vim-tmux-navigator <C-h> https://git.io/vS5QH
  nmap <BS> :<C-u>TmuxNavigateLeft<CR>
endif

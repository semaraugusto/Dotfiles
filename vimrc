" 
" Vim settings for @mscoutermarsh
"

" Settings in this file may depend on plugins, so let's install them first.
" Not to be confused with the contents of ~/.vim/plugin/* which are
" configuration options for each plugin and automatically loaded by Vim.
"
source ~/.vim/plugin/plugins.vim
let mapleader=','
let g:pymode_folding=0
let g:indent_guides_enable_on_vim_startup = 1
map <C-o> :NERDTreeToggle<CR>

" begin vim with vim -S and make it reopen last closed session
nnoremap <leader>s :mksession<CR>

" Syntastic
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
"
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0


let g:ycm_python_interpreter_path = ''
let g:ycm_python_sys_path = []
let g:ycm_extra_conf_vim_data = [
  \  'g:ycm_python_interpreter_path',
  \  'g:ycm_python_sys_path'
  \]
let g:ycm_global_ycm_extra_conf = '~/global_extra_conf.py'
nmap <leader>gt :YcmCompleter GoTo<CR>
" nmap <leader>gd :YcmCompleter GoToDefinition<CR>
nmap g] :vsp <CR>:exec("YcmCompleter GoToDefinitionElseDeclaration")<CR>
nmap <leader>g] :exec("YcmCompleter GoToDefinitionElseDeclaration")<CR>



" FZF
" set term=screen-256color

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

let g:fzf_command_prefix = 'Fzf'
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-buffer-line)
nnoremap <silent> <leader>f :FzfFiles<CR>
nnoremap <silent> <leader>F :FzfFiles ~<CR>
nnoremap <silent> <leader>b  :FzfBuffers<CR>
nnoremap <silent> <leader>l :FzfBLines<CR>
nnoremap <silent> <leader>`  :FzfMarks<CR>
" nnoremap <silent> <leader>p :FzfCommands<CR>
nnoremap <silent> <leader>t :FzfFiletypes<CR>
nnoremap <silent> <F1> :FzfHelptags<CR>
inoremap <silent> <F1> <ESC>:FzfHelptags<CR>
cnoremap <silent> <C-_> <C-u>:FzfCommands<CR>
let g:fzf_history_dir = '~/.local/share/fzf-history'

nmap gb <Plug>(exjumplist-previous-buffer) 
nmap gn <Plug>(exjumplist-next-buffer) 

nmap          <C-W>+     <C-W>+<SID>ws
nmap          <C-W>-     <C-W>-<SID>ws
nn <script>   <SID>ws+   <C-W>+<SID>ws
nn <script>   <SID>ws-   <C-W>-<SID>ws
nmap          <C-W>>     <C-W>><SID>ws
nmap          <C-W><     <C-W><<SID>ws
nn <script>   <SID>ws>   <C-W>><SID>ws
nn <script>   <SID>ws<   <C-W><<SID>ws
nmap          <SID>ws    <Nop> 


autocmd FileType md,tex inoremap ;M $$$$<Enter><Enter><++><Esc>2k$hi
map <leader>p :!zathura <c-r>%<backspace><backspace><backspace>pdf &<CR><CR>
" Leader Mappings
map <Space> <leader>
map <Leader>w :update<CR>
map <Leader>q :qall<CR>
map <Leader>gs :Gstatus<CR>

"navigating with guides
inoremap <leader><Tab> <Esc>/<++><Enter>"_c4l
vnoremap <leader><Tab> <Esc>/<++><Enter>"_c4l
map <leader><Tab> <Esc>/<++><Enter>"_c4l

" minhas modificacoes
" Clear highlighting on escape in normal mode
nnoremap <esc> :noh<return><esc>
nnoremap <esc>^[ <esc>^[

filetype plugin on

autocmd Filetype c inoremap ;f for(<++>) {<Enter>}<Esc><Esc>ko<++>
autocmd Filetype cpp inoremap ;f for(<++>) {<Enter>}<Esc><Esc>ko<++>

autocmd Filetype c inoremap ;i if(<++>) {<Enter>}<Esc><Esc>ko<++>
autocmd Filetype cpp inoremap ;i if(<++>) {<Enter>}<Esc><Esc>ko<++>

autocmd Filetype c inoremap ;m int main(<++>) {<Enter><Enter>}<Esc><Esc>kko<++><Enter><backspace>
autocmd Filetype cpp inoremap ;m #include <iostream><Enter><Enter>using namespace std;<Enter><Enter>int main(<++>) {<Enter>}<Esc><Esc>ko<++><Enter>return 0;<Esc>0xx

"Compiling .tex and .md/.Rmd
"Snippets for tex, md and Rmd
autocmd FileType tex inoremap <F5> <Esc>:!xelatex<space><c-r>%<Enter>a
autocmd FileType tex nnoremap <F5> :!xelatex<space><c-r>%<Enter>
autocmd FileType tex map <F3> :w !detex \| wc -w<CR>
autocmd FileType tex inoremap <F3> <Esc>:w !detex \| wc -w<CR>
" Compile document using xelatex:
autocmd FileType tex inoremap <F5> <Esc>:!xelatex<space><c-r>%<Enter>a
autocmd FileType tex nnoremap <F5> :!xelatex<space><c-r>%<Enter>

autocmd Filetype markdown map <F5> :!pandoc<space><C-r>%<space>--pdf-engine=xelatex<space>-o<space><C-r>%<backspace><backspace>pdf<Enter><Enter>
autocmd Filetype rmd map <F5> :!echo<space>"require(rmarkdown);<space>render('<c-r>%')"<space>\|<space>R<space>--vanilla<enter>

syntax on

" noremap <leader>p "*p
" noremap <leader>y "+y
" noremap <leader>d "+d
set clipboard=unnamedplus
set autoread                          " Auto reload changed files
set wildmenu                          " Tab autocomplete in command mode
set backspace=indent,eol,start        " http://vi.stackexchange.com/a/2163
" set clipboard=unnamed                 " Clipboard support (OSX)
set laststatus=2                      " Show status line on startup
set splitright                        " Open new splits to the right
set splitbelow                        " Open new splits to the bottom
"set lazyredraw                       " Reduce the redraw frequency
set ttyfast                           " Send more characters in fast terminals
"set nowrap                           " Don't wrap long lines
set listchars=extends:→               " Show arrow if line continues rightwards
set listchars+=precedes:←             " Show arrow if line continues leftwards
set nobackup nowritebackup noswapfile " Turn off backup files
set noerrorbells novisualbell         " Turn off visual and audible bells
set expandtab shiftwidth=4 tabstop=4  " Four spaces for tabs everywhere
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

"-------------------------------------------------------------------------------
" Colors & Formatting
"-------------------------------------------------------------------------------

" set background=dark

" Showcase comments in italics
" highlight Comment cterm=italic gui=italic

"-------------------------------------------------------------------------------
" Neovim-specific configurations
"-------------------------------------------------------------------------------
" colorscheme gruvbox
colorscheme nord
set background=dark
set termguicolors
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

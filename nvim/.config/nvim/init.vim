set path+=**
" Nice menu when typing `:find *.py`
set wildmode=longest,full
set wildmenu
" Ignore files
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=**/coverage/*
" set wildignore+=**/node_modules/*
set wildignore+=**/.git/*

autocmd BufRead * autocmd FileType <buffer> ++once
  \ if &ft !~# 'commit\|rebase' && line("'\"") > 1 && line("'\"") <= line("$") | exe 'normal! g`"' | endif

let mapleader=','
" status line
lua require("user.plugins")

" Automatically run :CratesToggle when opening a Cargo.toml file:
if has('nvim')
  autocmd BufRead Cargo.toml call crates#toggle()
endif

" Buffer navigation
nmap gb <Plug>(exjumplist-previous-buffer) 
nmap gn <Plug>(exjumplist-next-buffer) 

" Prettier
map gpp :call JsonBeautify()<CR>

" Easy window navigation
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

imap <leader>gau auto,e
" Copy remaps

nnoremap <leader>y "+y
vnoremap <leader>y "+y
" vnoremap <leader>p "+p
" nnoremap <leader>p "+p
nnoremap <leader>p "_dP
vnoremap <leader>p "_dP
" nnoremap <leader><leader>s <cmd>source ~/.config/nvim/lua/user/luasnip.lua<CR>

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

" set title
set autoread                          " Auto reload changed files
set wildmenu                          " Tab autocomplete in command mode
set backspace=indent,eol,start        " http://vi.stackexchange.com/a/2163
set laststatus=3                      " Show status line on startup
set splitright                        " Open new splits to the right
set splitbelow                        " Open new splits to the bottom
"set lazyredraw                        " Reduce the redraw frequency
set ttyfast                           " Send more characters in fast terminals
"set nowrap                            " Don't wrap long lines
set noerrorbells novisualbell         " Turn off visual and audible bells
set expandtab shiftwidth=4 tabstop=4  " Four spaces for tabs everywhere
set smarttab
set history=1000
set scrolloff=8
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
let g:snippets = "luasnip"

nnoremap <C-t> :NvimTreeToggle .<CR>


nnoremap <silent> <C-S-Up>      :m .-2<CR>==
nnoremap <silent> <C-S-Down>    :m .+1<CR>==
inoremap <silent> <C-S-Up>      <Esc>:m .-2<CR>==gi
inoremap <silent> <C-S-Down>    <Esc>:m .+1<CR>==gi
vnoremap <silent> <C-S-Up>      :m '>-2<CR>gv=gv
vnoremap <silent> <C-S-Down>    :m '<+1<CR>gv=gv



lua <<EOF
  -- OR setup with some options
  require("nvim-tree").setup({
    sort_by = "case_sensitive",
    view = {
      adaptive_size = true,
      mappings = {
        list = {
          { key = "u", action = "dir_up" },
        },
      },
    },
    renderer = {
      group_empty = true,
    },
    filters = {
      dotfiles = true,
    },
  })
  local opt = vim.opt
  opt.formatoptions = opt.formatoptions
    - "a" -- Auto formatting is BAD.
    - "t" -- Don't auto format my code. I got linters for that.
    + "c" -- In general, I like it when comments respect textwidth
    + "q" -- Allow formatting comments w/ gq
    - "o" -- O and o, don't continue comments
    + "r" -- But do continue when pressing enter.
    + "n" -- Indent past the formatlistpat, not underneath it.
    + "j" -- Auto-remove comments if possible.
    - "2" -- I'm not in gradeschool anymore

  local set_cursorline = function(event, value, pattern)
    vim.api.nvim_create_autocmd(event, {
      group = group,
      pattern = pattern,
      callback = function()
        vim.opt_local.cursorline = value
      end,
    })
  end
  set_cursorline("WinLeave", false)
  set_cursorline("WinEnter", true)
  set_cursorline("FileType", false, "TelescopePrompt")
  require("user.globals")
  require("user.lsp.dap")
  require("user.telescope.init")
  require("user.telescope.setup")
  require("user.telescope.mappings")
  require("user.luasnip")
  require("user.dap")

  require("hop").setup { keys = 'asdfghjkl;', jump_on_sole_occurrence = false } 
  -- place this in one of your configuration file(s)
  vim.api.nvim_set_keymap('n', 'f', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>", {})
  vim.api.nvim_set_keymap('n', 'F', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>", {})
  vim.api.nvim_set_keymap('o', '<leader>f', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, inclusive_jump = true })<cr>", {})
  vim.api.nvim_set_keymap('o', '<leader>F', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, inclusive_jump = true })<cr>", {})
  vim.api.nvim_set_keymap('', '<leader>t', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>", {})
  vim.api.nvim_set_keymap('', '<leader>T', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>", {})
  vim.api.nvim_set_keymap('n', '<leader>l', "<cmd>lua require'hop'.hint_lines({ hint_position = require'hop.hint'.HintPosition })<cr>", {})
  vim.api.nvim_set_keymap('v', '<leader>l', "<cmd>lua require'hop'.hint_lines({ hint_position = require'hop.hint'.HintPosition })<cr>", {})
  vim.api.nvim_set_keymap('o', '<leader>l', "<cmd>lua require'hop'.hint_lines({ hint_position = require'hop.hint'.HintPosition, inclusive_jump = true })<cr>", {})
  -- require("cmp_luasnip")
  -- require("luasnip")
  require("user.snips")
 
EOF

" let g:catppuccin_flavour = "frappe" " latte, frappe, macchiato, mocha
" colorscheme catppuccin
colorscheme gruvbox
set termguicolors
" set background=dark
  " require("lsp")
  " require("telescope.start")
  " <<EOF

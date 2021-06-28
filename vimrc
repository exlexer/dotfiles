syntax on

set noerrorbells
set tabstop=2
set shiftwidth=2
set expandtab
set autoindent
set smartindent
set nu
set number relativenumber
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set mouse=a
set colorcolumn=120
set nocompatible
set splitbelow
set splitright
set timeoutlen=1000 ttimeoutlen=0
highlight ColorColumn ctermbg=0 guibg=darkgray

filetype off

let g:python_host_prog="/Users/kylehilton/.pyenv/shims/python"

call plug#begin('~/.vim/plugged')

Plug 'preservim/nerdcommenter'
Plug 'ayu-theme/ayu-vim'
Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }
Plug 'git@github.com:moll/vim-node.git'
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plug 'junegunn/fzf', {'dir': '~/.fzf','do': './install --all'}
Plug 'junegunn/fzf.vim' 
Plug 'antoinemadec/coc-fzf'
Plug 'yuezk/vim-js'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'tpope/vim-fugitive'
Plug 'christoomey/vim-tmux-navigator'

call plug#end()
filetype plugin indent on

set termguicolors
let ayucolor="mirage"
colorscheme challenger_deep

nnoremap <SPACE> <Nop>
let mapleader=" "

" ==== CocFzf configuration ====
nnoremap <silent> <leader>a       :<C-u>CocFzfList diagnostics<CR>
nnoremap <silent> <leader>b       :<C-u>CocFzfList diagnostics --current-buf<CR>
nnoremap <silent> <leader>c       :<C-u>CocFzfList commands<CR>
nnoremap <silent> <leader>e       :<C-u>CocFzfList extensions<CR>
nnoremap <silent> <leader>l       :<C-u>CocFzfList location<CR>
nnoremap <silent> <leader>o       :<C-u>CocFzfList outline<CR>
nnoremap <silent> <leader>s       :<C-u>CocFzfList symbols<CR>
nnoremap <silent> <leader>p       :<C-u>FZF<CR>

" ==== CocExplorer configuration ====
let g:coc_explorer_global_presets = {
\   'floating': {
\     'position': 'floating',
\     'open-action-strategy': 'sourceWindow'
\   }
\ }
"
nnoremap <silent> <leader>e :CocCommand explorer --quit-on-open<CR>
nnoremap <silent> <leader>ef :CocCommand explorer --preset floating<CR>

" ==== NERDCommenter configuration ====
let g:NERDCreateDefaultMappings = 1

set path=.,node_modules

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

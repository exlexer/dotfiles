syntax on

set noerrorbells
set tabstop=4
set shiftwidth=4
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

set colorcolumn=120
highlight ColorColumn ctermbg=0 guibg=lightgrey

set nocompatible              " be iMproved, required
filetype off                  " required

let g:python_host_prog="/Users/kylehilton/.pyenv/shims/python"


" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'preservim/nerdcommenter'
Plugin 'git@github.com:rking/ag.vim.git'
Plugin 'morhetz/gruvbox'
Plugin 'git@github.com:moll/vim-node.git'
Plugin 'junegunn/fzf.vim'
Plugin 'junegunn/fzf'
Plugin 'jremmen/vim-ripgrep'
Plugin 'neoclide/coc.nvim'
Plugin 'yuezk/vim-js'
Plugin 'maxmellon/vim-jsx-pretty'

call vundle#end()            " required
filetype plugin indent on    " required

colorscheme gruvbox
set background=dark

" ==== ripgrep ====
if executable('rg')
  let g:rg_derive_root = 'true'
endif

" ==== Tab mapping ====
map <F4> :tabr<cr>
map <F7> :tabl<cr>
map <F5> :tabp<cr>
map <F6> :tabn<cr>
map <F3> :tabclose<cr>

" ==== CocExplorer configuration ====
nnoremap <space>e :CocCommand explorer<CR>

" ==== NERDCommenter configuration ====
let g:NERDCreateDefaultMappings = 1

" ==== FZF configuration ====
nnoremap <C-p> :GFiles<CR>

set path=.,node_modules

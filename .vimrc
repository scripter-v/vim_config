set t_Co=256 " ignored by neovim
if !has('nvim')
    set term=xterm-256color
endif

set termguicolors
set background=dark

set hidden
set nu

set mouse=a
set mousemodel=popup
set mousehide

set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4

set autoindent
set smartindent

set statusline=%<%f%h%m%r\ %b\ %{&encoding}\ 0x\ \ %l,%c%V\ %P 

let useycmplugin=0

call plug#begin('~/.vim/plugged')

if useycmplugin
    Plug 'Valloric/YouCompleteMe'
else
    if has('nvim')
        Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
        "else
        "    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
        "    Plug 'roxma/nvim-yarp'
        "    Plug 'roxma/vim-hug-neovim-rpc'
    endif
endif

Plug 'zchee/deoplete-go', { 'do': 'make'}
Plug 'tpope/vim-sensible'
Plug 'junegunn/seoul256.vim'
Plug 'iCyMind/NeoSolarized'
Plug 'vim-scripts/Arduino-syntax-file'
Plug 'vim-syntastic/syntastic'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
"Plug 'SirVer/ultisnips'
"Plug 'honza/vim-snippets'
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'mdempsky/gocode', { 'rtp': 'vim', 'do': '~/.vim/plugged/gocode/vim/symlink.sh' }
Plug 'tell-k/vim-autopep8'
Plug 'ctrlpvim/ctrlp.vim'

call plug#end()

"-------------------------------------
"
let g:localvimrc_sandbox = 0
let g:localvimrc_ask = 0

let g:neosolarized_contrast = "high"
let g:neosolarized_visibility = "high"
colorscheme NeoSolarized

let g:UltiSnipsExpandTrigger="<c-a>"

let g:ycm_confirm_extra_conf = 0

let g:go_fmt_command = "goimports"

let g:deoplete#enable_at_startup = 1

"--------------------------------------
"
let mapleader=";"

if has('nvim')
    :tnoremap <Esc> <C-\><C-n>
    au FileType go nnoremap <Leader>r :GoRun<CR><C-w><left>:startinsert<CR>
else
    au FileType go nnoremap <Leader>r :GoRun<CR>
endif

au FileType go nnoremap <Leader>; :GoMetaLinter<CR>
au FileType go nnoremap <Leader>c :ccl<CR>
au FileType go nnoremap ,d :GoRename<CR>
nnoremap q<right> <C-w><right>
nnoremap q<left> <C-w><left>
nnoremap <Leader>q :NERDTreeToggle<CR>
nnoremap <C-b> :make<CR>

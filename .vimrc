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

set nowrap

set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4

au FileType proto set shiftwidth=2
au FileType proto set softtabstop=2
au FileType proto set tabstop=2

au FileType jade set shiftwidth=2
au FileType jade set softtabstop=2
au FileType jade set tabstop=2

au FileType ruby set shiftwidth=2
au FileType ruby set softtabstop=2
au FileType ruby set tabstop=2

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
    else
        Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
        Plug 'roxma/nvim-yarp'
        Plug 'roxma/vim-hug-neovim-rpc'
    endif
endif
Plug 'jez/vim-jade'
Plug 'w0rp/ale'
Plug 'zchee/deoplete-go', { 'do': 'make' }
Plug 'tpope/vim-sensible'
Plug 'iCyMind/NeoSolarized'
Plug 'vim-scripts/Arduino-syntax-file'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }

if has('nvim')
    Plug 'mdempsky/gocode', { 'rtp': 'nvim' }
else
    Plug 'mdempsky/gocode', { 'rtp': 'vim' }
endif

Plug 'tell-k/vim-autopep8'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'zchee/deoplete-jedi'

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
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1

let g:deoplete#enable_at_startup = 1

let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'
let g:airline#extensions#ale#enabled = 1

let g:autopep8_on_save = 1
let g:autopep8_disable_show_diff=1

"-------------------------------------r
"
let mapleader=";"

if has('nvim')
    :tnoremap <Esc> <C-\><C-n>
    au FileType go nnoremap <Leader>r :GoRun<CR><C-w><left>:startinsert<CR>
else
    au FileType go nnoremap <Leader>r :GoRun<CR>
endif

autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

au FileType go nnoremap <Leader>; :GoMetaLinter<CR>
au FileType go nnoremap <Leader>c :ccl<CR>
au FileType go nnoremap <leader>d :GoRename<CR>
nnoremap q<right> <C-w><right>
nnoremap q<left> <C-w><left>
nnoremap <Leader>q :NERDTreeToggle<CR>
nnoremap <C-b> :make<CR>

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

au FileType yaml set shiftwidth=2
au FileType yaml set softtabstop=2
au FileType yaml set tabstop=2

au FileType go set wildignore+=*/vendor/* 

set autoindent
set smartindent

set statusline=%<%f%h%m%r\ %b\ %{&encoding}\ 0x\ \ %l,%c%V\ %P 

" neocomplete like
set completeopt+=noinsert
" deoplete.nvim recommend
set completeopt+=noselect

call plug#begin('~/.vim/plugged')

if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'deoplete-plugins/deoplete-go', { 'do': 'make'}
    let g:deoplete#enable_at_startup = 1
endif

Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'
Plug 'jez/vim-jade'
Plug 'w0rp/ale'
Plug 'tpope/vim-sensible'
Plug 'iCyMind/NeoSolarized'
Plug 'vim-scripts/Arduino-syntax-file'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }

if has('nvim')
    Plug 'stamblerre/gocode', { 'rtp': 'nvim', 'do': '~/.config/nvim/plugged/gocode/nvim/symlink.sh' }
else
    Plug 'stamblerre/gocode', { 'rtp': 'vim', 'do': '~/.vim/plugged/gocode/vim/symlink.sh' }
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

let g:go_fmt_command = "goimports"

let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1

let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'
let g:airline#extensions#ale#enabled = 1

let g:autopep8_on_save = 1
let g:autopep8_disable_show_diff=1

if executable('ag')
    let g:ackprg = 'ag --vimgrep'
endif

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

let g:gometalinter_cwd=getcwd()
let g:go_metalinter_command="gometalinter"
au FileType go nnoremap <Leader>; :execute ':GoMetaLinter ' . fnameescape(g:gometalinter_cwd) . '/...'<CR>

au FileType go nnoremap <Leader>c :ccl<CR>
au FileType go nnoremap <leader>d :GoRename<CR>
au FileType go nnoremap <leader>s :Ack --go --ignore-dir vendor 

nnoremap <Leader>a :Ag<CR>
nnoremap q<right> <C-w><right>
nnoremap q<left> <C-w><left>
nnoremap <Leader>q :NERDTreeToggle<CR>
nnoremap <C-b> :make<CR>
nnoremap <C-n> :cn<CR>
nnoremap <C-j> :cp<CR>

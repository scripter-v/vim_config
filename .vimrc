set t_Co=256 " ignored by neovim
if !has('nvim')
    set term=xterm-256color
    set fillchars+=vert:│
endif

set termguicolors
set background=dark
set clipboard+=unnamedplus

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

call plug#begin('~/.vim/plugged')

if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
    Plug 'Shougo/deoplete.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
endif

Plug 'stephpy/vim-yaml'
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
Plug 'tell-k/vim-autopep8'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'majutsushi/tagbar'
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'deoplete-plugins/deoplete-jedi'
Plug 'davidhalter/jedi-vim'

call plug#end()

call deoplete#custom#option('omni_patterns', { 'go': '[^. *\t]\.\w*' })

"-------------------------------------
let g:omni_sql_no_default_maps = 1

let g:deoplete#enable_at_startup = 1

let g:localvimrc_sandbox = 0
let g:localvimrc_ask = 0

let g:neosolarized_contrast = "high"
let g:neosolarized_visibility = "high"
colorscheme NeoSolarized

let g:UltiSnipsExpandTrigger="<c-a>"

let g:go_fmt_command = "goimports"
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
let g:go_referrers_mode = 'gopls'
let g:go_rename_command = 'gopls'
let g:go_metalinter_command='golangci-lint'
let g:go_metalinter_enabled=[]

let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1

"https://github.com/deoplete-plugins/deoplete-jedi/issues/35#issuecomment-281791696
let g:jedi#auto_vim_configuration = 0
let g:jedi#goto_assignments_command = ''  " dynamically done for ft=python.
let g:jedi#goto_definitions_command = '<C-]>'  " dynamically done for ft=python.
let g:jedi#use_tabs_not_buffers = 0  " current default is 1.
let g:jedi#rename_command = '<Leader>d'
let g:jedi#usages_command = '<Leader>gu'
let g:jedi#completions_enabled = 0
let g:jedi#smart_auto_mappings = 1

" Unite/ref and pydoc are more useful.
let g:jedi#documentation_command = 'K'
let g:jedi#auto_close_doc = 1

let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 0
let g:ale_linters = {
	\ 'go': ['gopls'],
	\}

let g:airline#extensions#ale#enabled = 1

let g:autopep8_on_save = 1
let g:autopep8_disable_show_diff=1

if executable('ag')
    let g:ackprg = 'ag --vimgrep'
endif

"-------------------------------------r
"
let mapleader=";"

"if has('nvim')
"    :tnoremap <Esc> <C-\><C-n>
"    au FileType go nnoremap <Leader>r :GoRun<CR><C-w><left>:startinsert<CR>
"else
    au FileType go nnoremap <Leader>r :GoRun<CR>
"endif

autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

au FileType go nnoremap <leader>; :GoMetaLinter --exclude-use-default=true<CR>

au FileType go nnoremap <Leader>c :ccl<CR>
au FileType go nnoremap <leader>d :GoRename<CR>
au FileType go nnoremap <leader>s :Ack --go --ignore-dir vendor 

nnoremap q<right> <C-w><right>
nnoremap q<left> <C-w><left>
nnoremap <Leader>q :NERDTreeToggle<CR>
nnoremap <Leader>e :TagbarToggle<CR>
nnoremap <C-b> :make<CR>

nnoremap <C-n> :NextError<CR>
nnoremap <C-j> :PrevError<CR>

com! -bar NextError  call s:GoForError("next")
com! -bar PrevError  call s:GoForError("previous")

func! s:GoForError(partcmd)
    try
        try
            exec "l". a:partcmd
        catch /:E776:/
            " No location list
            exec "c". a:partcmd
        endtry
    catch
        echohl ErrorMsg
        echomsg matchstr(v:exception, ':\zs.*')
        echohl None
    endtry
endfunc

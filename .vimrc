set t_Co=256 " ignored by neovim
if !has('nvim')
    set term=xterm-256color
    set fillchars+=vert:│
endif

set exrc

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
let g:deoplete#enable_at_startup = 1

Plug 'stephpy/vim-yaml'
Plug 'mileszs/ack.vim'
Plug 'dense-analysis/ale'
Plug 'bufbuild/vim-buf'
Plug 'tpope/vim-sensible'
Plug 'iCyMind/NeoSolarized'
Plug 'vim-scripts/Arduino-syntax-file'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'majutsushi/tagbar'
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'junegunn/fzf',
Plug 'junegunn/fzf.vim'
Plug 'neovim/nvim-lspconfig'

call plug#end()

"-------------------------------------
let g:omni_sql_no_default_maps = 1

let g:localvimrc_sandbox = 0
let g:localvimrc_ask = 0

let g:neosolarized_contrast = "high"
let g:neosolarized_visibility = "high"
colorscheme NeoSolarized

let g:UltiSnipsExpandTrigger="<c-a>"

let g:go_fmt_command = "gopls"
let g:go_gopls_gofumpt=1
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
let g:go_referrers_mode = 'gopls'
let g:go_rename_command = 'gopls'
let g:go_metalinter_command='golangci-lint'
let g:go_metalinter_enabled=[]

let g:go_highlight_build_constraints = 1
"let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_types = 1
let g:go_highlight_structs = 0
let g:go_highlight_operators = 0
let g:go_highlight_interfaces = 0

let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 0
let g:ale_linters = {
	\ 'go': ['gopls'],
    \ 'proto': ['buf-lint',],
    \ 'sh': [''],
    \ 'cpp': [''],
	\}

let g:airline#extensions#ale#enabled = 1

if executable('ag')
    let g:ackprg = 'ag --vimgrep'
endif

"-------------------------------------

let mapleader=";"

autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

au FileType go nnoremap <leader>; :GoMetaLinter<CR>
au FileType go nnoremap <leader>d :GoRename<CR>
au FileType go nnoremap <Leader>r :GoRun<CR>
au FileType go nnoremap <Leader>t :GoTest<CR>

au FileType go nnoremap <leader>s :Ack --go --ignore-dir vendor 

nnoremap q<right> <C-w><right>
nnoremap q<left> <C-w><left>
nnoremap <Leader>q :NERDTreeToggle<CR>
nnoremap <Leader>e :TagbarToggle<CR>
nnoremap <Leader>c :cclose<CR>
nnoremap <C-b> :make<CR>

augroup vimrcQfClose
    autocmd!
    autocmd FileType qf if mapcheck('<esc>', 'n') ==# '' | nnoremap <buffer><silent> <esc> :cclose<bar>lclose<CR> | endif
augroup END

nnoremap <C-n> :NextError<CR>
nnoremap <C-j> :PrevError<CR>

com! -bar NextError  call s:GoForError("next")
com! -bar PrevError  call s:GoForError("previous")

command! -nargs=1 -bang Mdfind call fzf#run(fzf#wrap( {'source': 'mdfind <q-args>', 'options': '-m'}, <bang>0))

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

xmap <silent> . :normal .<CR>
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

function! ExecuteMacroOverVisualRange()
    echo "@".getcmdline()
    execute ":'<,'>normal @" . nr2char(getchar())
endfunction

lua << EOF
require'lspconfig'.pyright.setup{}
require'lspconfig'.vimls.setup{}
require'lspconfig'.bashls.setup{}
require'lspconfig'.clangd.setup{}
require'lspconfig'.sumneko_lua.setup{}
require'lspconfig'.yamlls.setup{}

local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  --buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', '<C-]>', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'pyright', 'clangd', 'vimls', 'bashls', 'sumneko_lua', 'yamlls' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end
EOF

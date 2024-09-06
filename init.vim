filetype plugin on

" vim-plug
call plug#begin()

" There should be all plugins
Plug 'ray-x/lsp_signature.nvim'
Plug 'ranelpadon/python-copy-reference.vim'
Plug 'tpope/vim-surround'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release' }
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', {'branch': '0.1.x'}
Plug 'tpope/vim-sensible'
Plug 'machakann/vim-highlightedyank'

Plug 'tpope/vim-obsession'

Plug 'scrooloose/nerdtree'
"augroup nerdtree_open
    "autocmd!
    "autocmd VimEnter * NERDTree | wincmd p
"augroup END

Plug 'nvim-tree/nvim-web-devicons' " OPTIONAL: for file icons
Plug 'lewis6991/gitsigns.nvim' " OPTIONAL: for git status
Plug 'romgrk/barbar.nvim'

" autocomplete
"Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"let g:deoplete#enable_at_startup = 1
"Plug 'zchee/deoplete-jedi'

"" https://github.com/Shougo/deoplete.nvim/wiki/Completion-Sources
"Plug 'deoplete-plugins/deoplete-zsh'
"Plug 'deoplete-plugins/deoplete-docker'
Plug 'Shougo/neco-vim'
" status bar
Plug 'vim-airline/vim-airline'

" code editing part

" mason 
"Plug 'williamboman/mason.nvim'
"Plug 'williamboman/mason-lspconfig.nvim'
"Plug 'neovim/nvim-lspconfig'


Plug 'airblade/vim-gitgutter'
Plug 'tmhedberg/SimpylFold'

" auto place closed bracket
Plug 'jiangmiao/auto-pairs'

" comments
Plug 'scrooloose/nerdcommenter'
let g:NERDDefaultAlign = 'left'
let g:NERDCompactSexyComs = 1

" formatter
Plug 'sbdchd/neoformat'
" Enable alignment
let g:neoformat_basic_format_align = 1

" Enable tab to space conversion
let g:neoformat_basic_format_retab = 1

" Enable trimmming of trailing whitespace
let g:neoformat_basic_format_trim = 1

Plug 'davidhalter/jedi-vim'
" disable autocompletion, because we use deoplete for completion
"let g:jedi#completions_enabled = 0

" open the go-to function in split, not another buffer
let g:jedi#use_splits_not_buffers = "right"

Plug 'terryma/vim-multiple-cursors'

" python syntax highlight
Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins' }

" show current dot path
Plug 'neovim/nvim-lspconfig'
Plug 'SmiteshP/nvim-navic'


call plug#end()

" everything common
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
" <CR>: close popup and save indent.
"inoremap <silent> <CR> <Cmd>call <SID>my_cr_function()<CR>
"function! s:my_cr_function() abort
"return deoplete#close_popup() . "\<CR>"
"endfunction

"call deoplete#custom#option({
"\ 'auto_complete_delay': 200,
"\ 'smart_case': v:true,
"\ })

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

nnoremap gT <cmd>bprev<cr>
nnoremap gt <cmd>bnext<cr>

set number
set mouse+=a
set updatetime=100
set colorcolumn=121
set splitbelow

autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

let g:python_copy_reference = {
    \ 'remove_prefixes': ['apps', 'conf']
\ }
nnoremap <leader>cp <cmd>PythonCopReferenceDotted<cr>
let mapleader = ','

"lua require('mason').setup()
"lua require("mason-lspconfig").setup()

lua require('init')

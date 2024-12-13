let mapleader = ','
" set termguicolors " Default MacOS Terminal does not support true colors, so tell it to neovim
set nocompatible " disable compatibility with vi
set relativenumber " relative line numbers
set cursorline
set colorcolumn=120
set number " show current absolute line
set noshowmode " disable showing mode, because lightline shows it
set backspace=indent,eol,start " backspace over everything
" case-sensitive search when if search contains capitals
set ignorecase
set smartcase
set incsearch " searching as you type
set noerrorbells visualbell t_vb=
" Sane splits
set splitright
set splitbelow
" Permanent undo
set undodir=~/.vimdid
set undofile
" Indentation
set expandtab
set shiftwidth=4
" Position between scroll and border of buffer
set scrolloff=8
set termguicolors
set guioptions+=b
" Completion
" Better completion
" menuone: popup even when there's only one match
" noinsert: Do not insert text until a selection is made
" noselect: Do not select, force user to select one from the menu
set completeopt=menuone,noinsert,noselect
" Better display for messages
set cmdheight=2
" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300
set nowrap
set pumheight=8
set mouse+=a
set updatetime=100
au TextYankPost * silent! lua vim.highlight.on_yank() " Highlight yank

call plug#begin()

Plug 'neoclide/coc.nvim', {'branch': 'release'}

" git
Plug 'tpope/vim-fugitive'
Plug 'FabijanZulj/blame.nvim'

" float terminal
Plug 'voldikss/vim-floaterm'

Plug 'romgrk/barbar.nvim'

Plug 'vim-airline/vim-airline'

Plug 'scrooloose/nerdtree'
Plug 'nvim-tree/nvim-web-devicons' " OPTIONAL: for file icons

Plug 'tmhedberg/SimpylFold'

" auto place closed bracket
Plug 'jiangmiao/auto-pairs'
"session management

Plug 'tpope/vim-obsession'

" Interface Plug 'itchyny/lightline.vim'
Plug 'editorconfig/editorconfig-vim'

" fzf

Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release' }
Plug 'princejoogie/dir-telescope.nvim'
Plug 'nvim-telescope/telescope-ui-select.nvim'
Plug 'm-demare/attempt.nvim'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', {'branch': '0.1.x'}
Plug 'nvim-telescope/telescope-live-grep-args.nvim'
Plug 'nvim-telescope/telescope-file-browser.nvim'
"Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
"Plug 'junegunn/fzf.vim'

" Semantic language support
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/lsp_extensions.nvim'
"Plug 'hrsh7th/cmp-nvim-lsp', {'branch': 'main'}
"Plug 'hrsh7th/cmp-buffer', {'branch': 'main'}
"Plug 'hrsh7th/cmp-path', {'branch': 'main'}
"Plug 'hrsh7th/nvim-cmp', {'branch': 'main'}
Plug 'ray-x/lsp_signature.nvim'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'

" Plug 'navarasu/onedark.nvim'
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }

Plug 'stevearc/aerial.nvim'

Plug 'ranelpadon/python-copy-reference.vim'

" auto place closed bracket
"Plug 'jiangmiao/auto-pairs'
" For coc use :CocInstall coc-pairs

" comments
Plug 'scrooloose/nerdcommenter'

Plug 'davidhalter/jedi-vim'

Plug 'kevinhwang91/rnvimr'
" Plug 'dstein64/vim-startuptime'
call plug#end()


" let g:fzf_vim.preview_window = ['right,30%', 'ctrl--']
"let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.8 } }

" autocmd CursorHold,CursorHoldI *.rs :lua require'lsp_extensions'.inlay_hints{ only_current_line = true }

let g:lightline = {'colorscheme': 'catppuccin'}

colorscheme catppuccin-macchiato

" disable moving with arrows
" Do this in normal mode...
nnoremap <Left>  :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up>    :echoe "Use k"<CR>
nnoremap <Down>  :echoe "Use j"<CR>
" ...and in insert mode
"inoremap <Left>  <ESC>:echoe "Use h"<CR>
"inoremap <Right> <ESC>:echoe "Use l"<CR>
"inoremap <Up>    <ESC>:echoe "Use k"<CR>
"inoremap <Down>  <ESC>:echoe "Use j"<CR>
" ; as :
" nnoremap ; :


" Open hotkeys
map <C-p> :Files<CR>
" nmap <leader>; :Buffers<CR>

" Quick-save
nmap <leader>w :w<CR>

" Ctrl+h to stop searching
vnoremap <C-h> :nohlsearch<cr>
nnoremap <C-h> :nohlsearch<cr>

" Jump to start and end of line using the home row keys
map H ^
map L $

" Left and right can switch buffers
nnoremap <left> :bp<CR>
nnoremap <right> :bn<CR>

" I can type :help on my own, thanks.
map <F1> <Esc>
imap <F1> <Esc>

nnoremap <C-p> :GFiles<CR>
" Open new file adjacent to current file
nnoremap <leader>o :e <C-R>=expand("%:p:h") . "/" <CR>

nnoremap <silent><leader>2 :source $MYVIMRC<CR>
nnoremap <silent><leader>1 :source $MYVIMRC \| :PlugInstall<CR>

set nolist
set encoding=utf-8
scriptencoding utf-8
" set listchars=space:·
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·,space:·

nnoremap <silent><F9> :!black %<CR>
inoremap <silent><F9> :!black %<CR>

nnoremap <Leader>rd :PythonCopyReferenceDotted<CR>
nnoremap <Leader>rp :PythonCopyReferencePytest<CR>
nnoremap <Leader>ri :PythonCopyReferenceImport<CR>
let g:python_copy_reference = {
    \ 'remove_prefixes': ['web', 'home', 'zeebra38', 'projects']
\ }

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
"nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Telescope file browser
nnoremap <silent> <leader>fb :Telescope file_browser<CR>

" floaterm
nnoremap   <silent>   <leader>ftn    :FloatermNew<CR>
tnoremap   <silent>   <leader>ftn    <C-\><C-n>:FloatermNew<CR>
nnoremap   <silent>   <leader>ftp    :FloatermPrev<CR>
tnoremap   <silent>   <leader>ftp    <C-\><C-n>:FloatermPrev<CR>
nnoremap   <silent>   <leader>ftn    :FloatermNext<CR>
tnoremap   <silent>   <leader>ftn    <C-\><C-n>:FloatermNext<CR>
nnoremap   <silent>   <leader>ft   :FloatermToggle<CR>
tnoremap   <silent>   <leader>ft   <C-\><C-n>:FloatermToggle<CR>

" blame 
nnoremap <silent> <C-b> :BlameToggle window<CR>

" jedi
let g:jedi#show_call_signatures = 0

" ranger
tnoremap <silent> <leader>rr <C-\><C-n>:RnvimrResize<CR>
nnoremap <silent> <leader>rt :RnvimrToggle<CR>
tnoremap <silent> <leader>rt <C-\><C-n>:RnvimrToggle<CR>
"inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s)
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying code actions to the selected code block
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying code actions at the cursor position
nmap <leader>ac  <Plug>(coc-codeaction-cursor)
" Remap keys for apply code actions affect whole buffer
nmap <leader>as  <Plug>(coc-codeaction-source)
" Apply the most preferred quickfix action to fix diagnostic on the current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Remap keys for applying refactor code actions
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

" Run the Code Lens action on the current line
nmap <leader>cl  <Plug>(coc-codelens-action)

" Add `:Format` command to format current buffer
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

autocmd FileType python let b:coc_root_patterns = ['.venv', 'env']

" jedi config
let g:jedi#auto_vim_configuration = 0
let g:jedi#popup_on_dot = 0

" Устанавливаем текущую директорию равной открытому файлу
autocmd BufEnter * silent! lcd %:p:h

lua require('init')

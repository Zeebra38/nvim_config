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


Plug 'tmhedberg/SimpylFold'
"session management
Plug 'tpope/vim-obsession'

" Interface Plug 'itchyny/lightline.vim'
Plug 'editorconfig/editorconfig-vim'

" fzf

Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release' }
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', {'branch': '0.1.x'}
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Semantic language support
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/lsp_extensions.nvim'
Plug 'hrsh7th/cmp-nvim-lsp', {'branch': 'main'}
Plug 'hrsh7th/cmp-buffer', {'branch': 'main'}
Plug 'hrsh7th/cmp-path', {'branch': 'main'}
Plug 'hrsh7th/nvim-cmp', {'branch': 'main'}
Plug 'ray-x/lsp_signature.nvim'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'
Plug 'airblade/vim-gitgutter'

" Plug 'navarasu/onedark.nvim'
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }

Plug 'stevearc/aerial.nvim'

Plug 'ranelpadon/python-copy-reference.vim'

" auto place closed bracket
Plug 'jiangmiao/auto-pairs'

" comments
Plug 'scrooloose/nerdcommenter'

" Plug 'dstein64/vim-startuptime'
call plug#end()

" let g:fzf_vim.preview_window = ['right,30%', 'ctrl--']
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.8 } }

lua << EOF
local lspconfig = require'lspconfig'

-- Set up nvim-cmp.
local cmp = require'cmp'

cmp.setup({
  snippet = {
    -- REQUIRED by nvim-cmp. get rid of it once we can
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
  }, {
    { name = 'path' },
  }),
  experimental = {
      ghost_text = true,
  }
})

-- Enable completing paths in :
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  })
})

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
  -- Disable hover in favor of Pyright
  -- client.server_capabilities.hoverProvider = false
  client.server_capabilities.semanticTokensProvider = nil
end
-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
--   vim.lsp.diagnostic.on_publish_diagnostics, {
--     virtual_text = true,
--     signs = true,
--     update_in_insert = true,
--   }
-- )
-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
lspconfig.jedi_language_server.setup{
}
-- lspconfig.pyright.setup {
--     on_attach = on_attach,
--     flags = lsp_flags,
--     capabilities = capabilities,
--     settings = {
--         python = {
--             analysis = {
--                 autoSearchPaths = true,
--                 useLibraryCodeForTypes = true,
--                 diagnosticMode = 'openFilesOnly',
--                 reportMissingModuleSource = false,
--             },
--         },
--     },
-- }
lspconfig.ruff_lsp.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    init_options = {
        settings = {
            -- any extra cli arguments for ruff go here
            args = {
            },
        },
    },
}

require "lsp_signature".setup({
    hint_prefix = "",
})

require("catppuccin").setup({
    integrations = {
        cmp = true,
        treesitter = true,
    },
    dim_inactive = {
        enabled = true, -- dims the background color of inactive window
        shade = "dark",
        percentage = 0.15, -- percentage of the shade to apply to the inactive window
    },
    highlight_overrides = {
        all = function(colors)
            return {
                LineNr = { bg = colors.mantle },
                SignColumn = { bg = colors.mantle },
                DiagnosticHint = { bg = colors.mantle },
                DiagnosticInfo = { bg = colors.mantle },
                DiagnosticWarn = { bg = colors.mantle },
                DiagnosticError = { bg = colors.mantle },
                DiagnosticSignHint = { bg = colors.mantle },
                DiagnosticSignInfo = { bg = colors.mantle },
                DiagnosticSignWarn = { bg = colors.mantle },
                DiagnosticSignError = { bg = colors.mantle },
 
            }
        end
    },
    styles = {
        comments = { "italic" },
    },
})

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "lua", "vim", "vimdoc", "query", "python" },

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  highlight = {
    enable = true,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

require("aerial").setup({
  -- optionally use on_attach to set keymaps when aerial has attached to a buffer
  on_attach = function(bufnr)
    -- Jump forwards/backwards with '{' and '}'
    vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
    vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
  end,
})
-- You probably also want to set a keymap to toggle aerial
vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>")
EOF

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
inoremap <Left>  <ESC>:echoe "Use h"<CR>
inoremap <Right> <ESC>:echoe "Use l"<CR>
inoremap <Up>    <ESC>:echoe "Use k"<CR>
inoremap <Down>  <ESC>:echoe "Use j"<CR>
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
    \ 'remove_prefixes': ['web']
\ }

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>


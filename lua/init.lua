--[[require("mason").setup()
   [require("mason-lspconfig").setup()]]


--[[
   [local builtin = require('telescope.builtin')
   [vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
   [vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
   [vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
   [vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
   [
   [local lspconfig = require'lspconfig'
   [lspconfig.jedi_language_server.setup{}
   [
   [lspconfig.ruff_lsp.setup {
   [    on_attach = on_attach,
   [    capabilities = capabilities,
   [    init_options = {
   [        settings = {
   [            -- any extra cli arguments for ruff go here
   [            args = {
   [            },
   [        },
   [    },
   [}
   [
   [require "lsp_signature".setup({
   [    hint_prefix = "",
   [})
   [
   [require'nvim-treesitter.configs'.setup {
   [  -- A list of parser names, or "all" (the five listed parsers should always be installed)
   [  ensure_installed = { "lua", "vim", "vimdoc", "query", "python" },
   [
   [  -- Automatically install missing parsers when entering buffer
   [  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
   [  auto_install = true,
   [
   [  highlight = {
   [    enable = true,
   [
   [    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
   [    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
   [    -- Using this option may slow down your editor, and you may see some duplicate highlights.
   [    -- Instead of true it can also be a list of languages
   [    additional_vim_regex_highlighting = false,
   [  },
   [}
   [
   ]]



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


local telescope = require("telescope")
-- first setup telescope
telescope.setup({
    -- your config
})

-- then load the extension
telescope.load_extension("live_grep_args")

vim.keymap.set("n", "<leader>fg", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")

require("dir-telescope").setup({
      hidden = true,
      no_ignore = false,
      show_preview = true,
      follow_symlinks = false,
    })
telescope.load_extension("dir")

vim.keymap.set("n", "<leader>fd", "<cmd>Telescope dir live_grep<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>pd", "<cmd>Telescope dir find_files<CR>", { noremap = true, silent = true })

require('attempt').setup()
require('telescope').load_extension('attempt')

local attempt = require('attempt')

vim.keymap.set('n', '<leader>an', attempt.new_select)        -- new attempt, selecting extension
vim.keymap.set('n', '<leader>ai', attempt.new_input_ext)     -- new attempt, inputing extension
vim.keymap.set('n', '<leader>ar', attempt.run)               -- run attempt
vim.keymap.set('n', '<leader>ad', attempt.delete_buf)        -- delete attempt from current buffer
vim.keymap.set('n', '<leader>ac', attempt.rename_buf)        -- rename attempt from current buffer
vim.keymap.set('n', '<leader>al', '<cmd>Telescope attempt<CR>', {noremap = true, silent = true})       -- search through attempts
--or: map('n', '<leader>al', attempt.open_selectcope attempt -- use ui.select instead of telescope

require('blame').setup({})

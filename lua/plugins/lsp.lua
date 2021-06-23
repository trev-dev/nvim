local lsp = require'lspconfig'
local map = vim.api.nvim_set_keymap
local options = { noremap = true, silent = true }
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true


-- Language Servers
lsp.pyright.setup{}
lsp.bashls.setup{}
lsp.intelephense.setup{}
lsp.tsserver.setup{}
lsp.tailwindcss.setup{}
lsp.vuels.setup{}
lsp.svelte.setup{}
lsp.html.setup{ capabilities = capabilities }
lsp.cssls.setup{ capabilities = capabilities }

-- Bindings
map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', options)
map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', options)
map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', options)
map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', options)
map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', options)
map('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', options)
map('n', '<C-n>', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', options)
map('n', '<C-p>', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', options)

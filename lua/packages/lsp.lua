local lsp = require'lspconfig'
local configs = require'lspconfig.configs'
local map = vim.api.nvim_buf_set_keymap
local options = { noremap = true, silent = true }
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

capabilities.textDocument.completion.completionItem.snippetSupport = true

local signs = { Error = "»", Warn = "»", Hint = "›", Info = "›" }
local M = {}
local config = {
  -- disable virtual text
  virtual_text = false,
  -- show signs
  signs = {
    active = signs,
  },
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
}

-- Bindings on Attach
on_attach = function(client, bufnr)
  map(bufnr, 'n', '<leader>e', '<cmd>lua vim.lsp.buf.definition()<CR>', options)
  map(bufnr, 'n', '<leader>c', '<cmd>lua vim.lsp.buf.declaration()<CR>', options)
  map(bufnr, 'n', '<leader>r', '<cmd>lua vim.lsp.buf.references()<CR>', options)
  map(bufnr, 'n', '<leader>t', '<cmd>lua vim.lsp.buf.type_definition()<CR>', options)
  map(bufnr, 'n', '<leader>i', '<cmd>lua vim.lsp.buf.implementation()<CR>', options)
  map(bufnr, 'n', '<leader>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', options)
  map(bufnr, 'n', '<leader>r', '<cmd>lua vim.lsp.buf.references()<CR>', options)
  map(bufnr, 'n', '<leader>F', '<cmd>lua vim.lsp.buf.formatting()<CR>', options)
  map(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', options)
  map(bufnr, 'i', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', options)
  map(bufnr, 'n', '<C-p>', '<cmd>lua vim.diagnostic.goto_prev()<CR>', options)
  map(bufnr, 'n', '<C-n>', '<cmd>lua vim.diagnostic.goto_next()<CR>', options)
  map(bufnr, 'n', '<C-h>', '<cmd>lua vim.diagnostic.open_float()<CR>', options)
  map(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', options)
  map(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', options)
  map(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', options)
  map(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', options)
end

-- Language Servers
if not configs.shopifyls then
  configs.shopifyls = {
    default_config = {
      cmd = {"theme-check-language-server"},
      root_dir = lsp.util.root_pattern('.shopifyignore', '.git'),
      filetypes = {'liquid'},
      settings = {}
    }
  }
end

-- Customizations
M.setup = function()
  local servers = {
    "pyright", "bashls", "intelephense", "tsserver", "tailwindcss", "vuels",
    "svelte", "html", "cssls", "shopifyls", "solargraph"
  }
  for _, srv in pairs(servers) do
    lsp[srv].setup{
      on_attach = on_attach, 
      capabilities = capabilities,
    }
  end
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end
  vim.diagnostic.config(config)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })
end

return M

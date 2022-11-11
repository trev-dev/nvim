local ok, lspcfg = pcall(require, "lspconfig")
if not ok then return end

local ok, lspsig = pcall(require, "lsp_signature")
if ok then
  lspsig.setup({
    bind = true,
    handler_opts = {
      border = "rounded"
    },
    doc_lines = 0,
    hint_enable = false
  })
end

local signs = { Error = "»", Warn = "»", Hint = "›", Info = "›" }

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

local bind = require("utils").bind
local on_attach = function(_, buff)
  bind("<leader>e", "lua vim.lsp.buf.definition()",
       { local_bind = true, buffer = buff })
  bind("<leader>c", "lua vim.lsp.buf.declaration()",
       { local_bind = true, buffer = buff })
  bind("<leader>r", "lua vim.lsp.buf.references()",
       { local_bind = true, buffer = buff })
  bind("<leader>t", "lua vim.lsp.buf.type_definition()",
       { local_bind = true, buffer = buff })
  bind("<leader>i", "lua vim.lsp.buf.implementation()",
       { local_bind = true, buffer = buff })
  bind("<leader>a", "lua vim.lsp.buf.code_action()",
       { local_bind = true, buffer = buff })
  bind("<leader>r", "lua vim.lsp.buf.references()",
       { local_bind = true, buffer = buff })
  bind("<leader>F", "lua vim.lsp.buf.format({async = true})",
       { local_bind = true, buffer = buff })
  bind("K", "lua vim.lsp.buf.hover()",
       { local_bind = true, buffer = buff })
  bind("<C-i>", "lua vim.lsp.buf.signature_help()",
       { local_bind = true, buffer = buff })
  bind("<C-p>", "lua vim.diagnostic.goto_prev()",
       { local_bind = true, buffer = buff })
  bind("<C-n>", "lua vim.diagnostic.goto_next()",
       { local_bind = true, buffer = buff })
  bind("<C-h>", "lua vim.diagnostic.open_float()",
       { local_bind = true, buffer = buff })
  bind("<space>wa", "lua vim.lsp.buf.add_workspace_folder()",
       { local_bind = true, buffer = buff })
  bind("<space>wr", "lua vim.lsp.buf.remove_workspace_folder()",
       { local_bind = true, buffer = buff })
  bind("<space>wl", "lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))",
       { local_bind = true, buffer = buff })
  bind("<space>rn", "lua vim.lsp.buf.rename()",
       { local_bind = true, buffer = buff })
end

local configs = require("lspconfig.configs")
-- Language Servers
configs.shopifyls = {
  default_config = {
    cmd = {"theme-check-language-server"},
    root_dir = lspcfg.util.root_pattern(".shopifyignore", ".git"),
    filetypes = {"liquid"},
    settings = {}
  }
}

local servers = {
  {"bashls", {}},
  {"cssls", {}},
  {"html", {}},
  {"intelephense", {}},
  {"jedi_language_server", {}},
  {"nimls", {}},
  {"rnix", {}},
  {"shopifyls", {}},
  {"solargraph", {}},
  {"sumneko_lua", {
    Lua = {
      runtime = {
        version = "LuaJIT"
      }
    },
    diagnostics = {
      globals = {"vim"}
    },
    workspace = {
      library = vim.api.nvim_get_runtime_file("", true)
    },
    telemetry = {
      enable = false
    },
    on_attach = on_attach
  }},
  {"svelte", {}},
  {"tsserver", {}},
  {"vuels", {}},
  {"yamlls", {}},
}

local merge = require("utils").merge
for _, server in pairs(servers) do
  local name = server[1]
  local conf = merge({ on_attach = on_attach }, server[2])
  lspcfg[name].setup(conf)
end

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config(config)

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover, { border = "rounded", }
)

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.signature_help, { border = "rounded" }
)

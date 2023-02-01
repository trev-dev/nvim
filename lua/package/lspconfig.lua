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
  local list_buffs = function()
    print(vim.lsp.buf.list_workspace_folders())
  end
  local format_buff = function()
    vim.lsp.buf.format {async = true}
  end
  local bufopts = { buffer = buff }
  bind('gD', vim.lsp.buf.declaration, bufopts)
  bind('gd', vim.lsp.buf.definition, bufopts)
  bind('K', vim.lsp.buf.hover, bufopts)
  bind('gI', vim.lsp.buf.implementation, bufopts)
  bind('<C-h>', vim.lsp.buf.signature_help, bufopts)
  bind("H", vim.diagnostic.open_float, bufopts)
  bind('<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  bind('<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  bind('<space>wl', list_buffs, bufopts)
  bind('<space>D', vim.lsp.buf.type_definition, bufopts)
  bind('<space>rn', vim.lsp.buf.rename, bufopts)
  bind('<space>ca', vim.lsp.buf.code_action, bufopts)
  bind('gr', vim.lsp.buf.references, bufopts)
  bind('<space>f', format_buff, bufopts)
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
  {"hls", {}},
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
  {"eslint", {}},
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

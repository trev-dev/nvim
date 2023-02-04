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

local on_attach = function(_, buff)
  local bind = vim.keymap.set
  local list_buffs = function() print(vim.lsp.buf.list_workspace_folders()) end
  local format_buff = function() vim.lsp.buf.format {async = true} end
  local with_desc = function(desc) return { buffer = buff, desc = desc } end

  bind("n", "gD", vim.lsp.buf.declaration, with_desc("Goto declaration"))
  bind("n", "gd", vim.lsp.buf.definition, with_desc("Goto definition"))
  bind("n", "K", vim.lsp.buf.hover, with_desc("View hover info"))
  bind("n", "gI", vim.lsp.buf.implementation, with_desc("Show implementation"))
  bind("n", "<C-h>", vim.lsp.buf.signature_help, with_desc("Signature help"))
  bind("n", "H", vim.diagnostic.open_float, with_desc("Open diagnostic"))
  bind("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, with_desc("Add workspace folder"))
  bind("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, with_desc("Remove workspace folder"))
  bind("n", "<leader>wl", list_buffs, with_desc("List workspace buffers"))
  bind("n", "<leader>D", vim.lsp.buf.type_definition, with_desc("Goto definition"))
  bind("n", "<leader>rn", vim.lsp.buf.rename, with_desc("Rename symbol"))
  bind("n", "<leader>ca", vim.lsp.buf.code_action, with_desc("Code action"))
  bind("n", "gr", vim.lsp.buf.references, with_desc("Show references"))
  bind("n", "<leader>F", format_buff, with_desc("Format buffer"))
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
  {"jsonls", {}},
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

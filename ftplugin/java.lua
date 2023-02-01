local jdtls = require "jdtls"
local home = os.getenv "HOME"
local jdtls_path = home .. "/.local/share/nvim/mason/packages/jdtls"
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_root = home .. "/.cache/jdtls/"
local workspace = workspace_root .. project_name

local bind = require("utils").bind
local on_attach = function(_, buff)
  local list_buffs = function()
    print(vim.lsp.buf.list_workspace_folders())
  end
  local format_buff = function()
    vim.lsp.buf.format {async = true}
  end
  local bufopts = { buffer = buff }
  bind("gD", vim.lsp.buf.declaration, bufopts)
  bind("gd", vim.lsp.buf.definition, bufopts)
  bind("K", vim.lsp.buf.hover, bufopts)
  bind("gI", vim.lsp.buf.implementation, bufopts)
  bind("<C-h>", vim.lsp.buf.signature_help, bufopts)
  bind("H", vim.diagnostic.open_float, bufopts)
  bind("<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
  bind("<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
  bind("<space>wl", list_buffs, bufopts)
  bind("<space>D", vim.lsp.buf.type_definition, bufopts)
  bind("<space>rn", vim.lsp.buf.rename, bufopts)
  bind("<space>ca", vim.lsp.buf.code_action, bufopts)
  bind("gr", vim.lsp.buf.references, bufopts)
  bind("<space>f", format_buff, bufopts)

  bind("<A-o>", jdtls.organize_imports, bufopts)
  bind("crv", jdtls.extract_variable, bufopts)
  bind("crv", jdtls.extract_variable, { buffer = buff, mode = "v" })
  bind("crc", jdtls.extract_constant, bufopts)
  bind("crc", jdtls.extract_constant, { buffer = buff, mode = "v" })
  bind("crm", jdtls.extract_method, { buffer = buff, mode = "v" })
end

-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local config = {
  -- The command that starts the language server
  -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
  cmd = {

    -- 💀
    'java', -- or '/path/to/java17_or_newer/bin/java'
            -- depends on if `java` is in your $PATH env variable and if it points to the right version.

    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xms1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',

    -- 💀
    '-jar', vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar"),

    -- 💀
    '-configuration', jdtls_path .. '/config_linux',

    -- 💀
    -- See `data directory configuration` section in the README
    '-data', workspace
  },

  -- 💀
  -- This is the default if not provided, you can remove it. Or adjust as needed.
  -- One dedicated LSP server & client will be started per unique root_dir
  root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew', "pom.xml"}),

  -- Here you can configure eclipse.jdt.ls specific settings
  -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  -- for a list of options
  settings = {
    java = {
    }
  },

  -- Language server `initializationOptions`
  -- You need to extend the `bundles` with paths to jar files
  -- if you want to use additional eclipse.jdt.ls plugins.
  --
  -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
  --
  -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
  init_options = {
    bundles = {}
  },
}
-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
require('jdtls').start_or_attach(config)

local jdtls = require "jdtls"
local home = os.getenv "HOME"
local jdtls_path = home .. "/.local/share/nvim/mason/packages/jdtls"
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_root = home .. "/.cache/jdtls/"
local workspace = workspace_root .. project_name

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
  bind("n", "<space>wa", vim.lsp.buf.add_workspace_folder, with_desc("Add workspace folder"))
  bind("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, with_desc("Remove workspace folder"))
  bind("n", "<space>wl", list_buffs, with_desc("List workspace buffers"))
  bind("n", "<space>D", vim.lsp.buf.type_definition, with_desc("Goto definition"))
  bind("n", "<space>rn", vim.lsp.buf.rename, with_desc("Rename symbol"))
  bind("n", "<space>ca", vim.lsp.buf.code_action, with_desc("Code action"))
  bind("n", "gr", vim.lsp.buf.references, with_desc("Show references"))
  bind("n", "<space>f", format_buff, with_desc("Format buffer"))

  local wkp, wk = pcall(require, "which-key")
  if wkp then
    wk.register {r = {name = "Refactor"}, prefix = "c"}
  end

  bind("n", "<A-o>", jdtls.organize_imports, with_desc("Organize imports"))
  bind("n", "crv", jdtls.extract_variable, with_desc("Extract variable"))
  bind("n", "crv", jdtls.extract_variable, with_desc("Extract variable"))
  bind("n", "crc", jdtls.extract_constant, with_desc("Extract constant"))
  bind("n", "crc", jdtls.extract_constant, with_desc("Extract constant"))
  bind("n", "crm", jdtls.extract_method, with_desc("Extract method"))
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

  on_attach = on_attach,

  -- 💀
  -- This is the default if not provided, you can remove it. Or adjust as needed.
  -- One dedicated LSP server & client will be started per unique root_dir
  root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew', "pom.xml"}),

  -- Here you can configure eclipse.jdt.ls specific settings
  -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  -- for a list of options
  settings = {
    java = {
      signatureHelp = { enabled = true };
      contentProvider = { preferred = 'fernflower' };
      completion = {
        favoriteStaticMembers = {
          "org.hamcrest.MatcherAssert.assertThat",
          "org.hamcrest.Matchers.*",
          "org.hamcrest.CoreMatchers.*",
          "org.junit.jupiter.api.Assertions.*",
          "java.util.Objects.requireNonNull",
          "java.util.Objects.requireNonNullElse",
          "org.mockito.Mockito.*"
        }
      };
      sources = {
        organizeImports = {
          starThreshold = 9999;
          staticStarThreshold = 9999;
        };
      };
      codeGeneration = {
        toString = {
          template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
        }
      };
      configuration = {
        runtimes = { }
      };
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

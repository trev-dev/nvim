local parser_configs = require('nvim-treesitter.parsers').get_parser_configs()
local M = {}

--[[ function _G.javascript_indent()
  local line = vim.fn.getline(vim.v.lnum)
  local prev_line = vim.fn.getline(vim.v.lnum - 1)
  if line:match('^%s*[%*/]%s*') then
    if prev_line:match('^%s*%*%s*') then
      return vim.fn.indent(vim.v.lnum - 1)
    end
    if prev_line:match('^%s*/%*%*%s*$') then
      return vim.fn.indent(vim.v.lnum - 1) + 1
    end
  end
  return vim.fn['GetJavascriptIndent']()
end
 ]]

M.setup = function()
  -- require'orgmode'.setup_ts_grammar()
  require'nvim-treesitter.configs'.setup {
    -- One of "all", "maintained" (parsers with maintainers), or a list of languages
    ensure_installed = {
      "bash",
      "css",
      "html",
      "javascript",
      "json",
      "lua",
      "markdown",
      "nix",
      "php",
      "python",
      "scheme",
      "toml",
      "typescript",
      "vim",
      "yaml"
    },
    -- Install languages synchronously (only applied to `ensure_installed`)
    sync_install = false,
    -- Ignored langauges
    -- ignore_install = { "javascript" },
    highlight = {
      -- `false` will disable the whole extension
      enable = true,
      additional_vim_regex_highlighting = {'org'},
      disable = { "help" }
      -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
      -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
      -- Using this option may slow down your editor, and you may see some duplicate highlights.
      -- Instead of true it can also be a list of languages
    },
    -- ensure_installed = {'org'}
  }

  -- vim.cmd[[autocmd FileType javascript setlocal indentexpr=v:lua.javascript_indent()]]
end

return M

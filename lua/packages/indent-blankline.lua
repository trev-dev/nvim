local g = vim.g
local indentbl = require'indent_blankline'

return {
  setup = function()
    indentbl.setup{
      show_current_context = true,
      show_current_context_start = true,
      use_treesitter = true,
      show_trailing_blankline_indent = true
    }

    g.indent_blankline_filetype_exclude = {
      "lspinfo",
      "packer",
      "checkhealth",
      "help",
      "txt",
      "md",
      "org",
      "norg",
      "",
    }
  end
}

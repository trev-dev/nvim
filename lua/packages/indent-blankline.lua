local g = vim.g
local indentbl = require'indent_blankline'

return {
  setup = function()
    indentbl.setup{
      show_current_context = true,
      use_treesitter = true,
      show_trailing_blankline_indent = true,
      char_blankline = '┆',
      context_char_blankline = '┆'
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
    }
  end
}

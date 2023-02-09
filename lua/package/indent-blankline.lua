local ok, indentbl = pcall(require, "indent_blankline")
if not ok then return end

indentbl.setup({
  show_current_context = true,
  show_current_context_start = true,
  use_treesitter = true,
  show_trailing_blankline_indent = true,
  char_blankline = "┆",
  context_char_blankline = "┆",
})

vim.g.indent_blankline_filetype_exclude = {
  "lspinfo",
  "packer",
  "checkhealth",
  "help",
  "txt",
  "md",
  "org",
  "norg",
}

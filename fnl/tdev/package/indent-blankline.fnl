(module tdev.package.indent-blankline)

(let [(ok? indent-blankline) (pcall #(require :indent-blankline))]
  (when ok?
    (indent-blankline.setup
      {:show_current_context true
       :use_treesitter true
       :show_trailing_blankline_indent true
       :char_blankline "┆"
       :context_char_blankline "┆"})
    (set vim.g.indent_blankline_filetype_exclude
         ["lspinfo" "packer" "checkhealth" "help" "txt" "md" "org" "norg"])))

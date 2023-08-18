(module config.plugin.indent-blankline)

(let [ib (require :indent_blankline)]
  (ib.setup {:show_current_context true
             :show_current_context_start true
             :use_treesitter true
             :show_trailing_blankline_indent true
             :char_blankline "┆"
             :context_char_blankline "┆"}))

(set vim.g.indent_blankline_filetype_exclude [:lspinfo
                                              :packer
                                              :checkhealth
                                              :help
                                              :txt
                                              :markdown
                                              :org
                                              :norg])

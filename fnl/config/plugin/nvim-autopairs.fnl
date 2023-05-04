(module config.plugin.nvim-autopairs)

(let [ap (require :nvim-autopairs)
      quotes ["'" "`"]
      filetypes [:scheme :lisp :fennel :clojure :guile]]
  (ap.setup {:enable_check_bracket_line false})
  (each [_ q (ipairs quotes)]
    (tset (. (ap.get_rules q) 1) :not_filetypes filetypes)))

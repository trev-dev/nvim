(module config.plugin.oil)

(let [o (require :oil)
      map vim.keymap.set]
  (o.setup)
  (map :n :<leader>o (λ [] (o.open))))

(module config.plugin.vim-dadbod)

(set vim.g.db_ui_use_nerd_fonts 1)

(let [map vim.keymap.set]
  (map :n :<leader>gd ":DBUI<CR>" {:desc "dadbod ui"})
  (map :v :<leader>db ":DB<CR>" {:desc "dadbod execute"}))

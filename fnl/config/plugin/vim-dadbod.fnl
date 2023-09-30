(module config.plugin.vim-dadbod)

(set vim.g.db_ui_use_nerd_fonts 1)
(set vim.g.db_ui_auto_execute_table_helpers 1)
(set vim.g.db_ui_winwidth 80)

(let [map vim.keymap.set]
  (map :n :<leader>td ":DBUI<CR>" {:desc "dadbod ui"}))

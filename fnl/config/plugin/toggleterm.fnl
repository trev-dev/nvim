(module config.plugin.toggleterm)

(let [tt (require :toggleterm)]
  (tt.setup {:close_on_exit true
             :open_mapping "<A-t>"
             :direction :float
             :float_opts {:border :curved
                          :highlights {:background :Normal
                                       :border :Normal}
                          :winblend 0}
             :hide_numbers true
             :insert_mappings true
             :persist_size true
             :shade_filetypes {}
             :shade_terminals true
             :shading_factor 2
             :shell vim.o.shell
             :start_in_insert true}))

(let [Terminal (. (require :toggleterm.terminal) :Terminal)
      map vim.keymap.set
      lazygit (Terminal:new {:cmd :lazygit :hidden true})
      taskwarrior-tui (Terminal:new {:cmd :taskwarrior-tui :hidden true})]
  (λ toggle-lazygit [] (set lazygit.dir (vim.fn.getcwd)) (lazygit:toggle))
  (λ toggle-tui [] (taskwarrior-tui:toggle))
  (map :n :<leader>tg toggle-lazygit {:desc :lazygit})
  (map :n :<leader>tt toggle-tui {:desc :taskwarrior-tui}))

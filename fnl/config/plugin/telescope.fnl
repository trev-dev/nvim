(module config.plugin.telescope)

(let [t (require :telescope)
      t-themes (require :telescope.themes)]
  (t.setup {:defaults {:path_display {:truncate 3}}
            :extensions {:ui-select (t-themes.get_dropdown {})}})
  (t.load_extension "ui-select"))

(let [wk (require :which-key)]
  (wk.register {:f {:name :Find} :prefix :<leader>}))

(let [map vim.keymap.set
      t-builtin (require :telescope.builtin)]
  (map :n "<leader>ff" t-builtin.find_files { :desc "files" })
  (map :n "<leader>fr" t-builtin.live_grep { :desc "grep" })
  (map :n "<leader>fg" t-builtin.git_files { :desc "git files" })
  (map :n "<leader>fb" t-builtin.buffers { :desc "buffers" })
  (map :n "<leader>fh" t-builtin.help_tags { :desc "help tags" }))

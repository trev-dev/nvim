(module config.plugin.todo-comments)

(let [tc (require :todo-comments)]
  (tc.setup {:keywords {:TODO {:icon " " :color "info"}
                        :DONE {:icon " " :color "comment"}}
             :colors {:comment ["Comment"]}}))

(vim.keymap.set :n "<leader>ft" ":TodoTelescope<CR>" {:desc "todos"})

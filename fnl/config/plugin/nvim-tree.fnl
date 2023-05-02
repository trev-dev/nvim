(module config.plugin.nvim-tree)

(let [nt (require :nvim-tree)]
  (nt.setup {:view {:width 50}
             :renderer {:group_empty true
                        :highlight_git true}}))

(vim.keymap.set :n :<leader>n ":NvimTreeToggle<CR>")

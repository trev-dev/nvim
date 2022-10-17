(module tdev.package.toggleterm
  {autoload {utils tdev.utils}})

(let [(ok? toggleterm) (pcall #(require :toggleterm))]
  (when ok?
    (toggleterm.setup
      {:size 20
       :open_mapping "<c-\\>"
       :hide_numbers true
       :shade_filetypes {}
       :shade_terminals true
       :shading_factor 2
       :start_in_insert true
       :insert_mappings true
       :persist_size true
       :direction "float"
       :close_on_exit true
       :shell vim.o.shell
       :float_opts {:border "curved"
                    :winblend 0
                    :highlights {:border "Normal" :background "Normal"}}})
    (let [term (. (require :toggleterm.terminal) :Terminal)
          lazygit (term:new {:cmd "lazygit" :hidden true :dir "git_dir"})]
      (global _LAZYGIT_TOGGLE (fn [] (lazygit:toggle)))
      (utils.map :gs "lua _LAZYGIT_TOGGLE()"))))

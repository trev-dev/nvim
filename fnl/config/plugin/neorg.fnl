(module config.plugin.neorg)

(let [n (require :neorg)]
  (n.setup {:load {:core.defaults {}
                   :core.export {}
                   :core.highlights {}
                   :core.integrations.treesitter {}
                   :core.mode {}
                   :core.neorgcmd {}
                   :core.completion {:config {:engine "nvim-cmp"}}
                   :core.concealer {:config {:icon_preset "diamond"}}
                   :core.dirman {:config
                                 {:workspaces
                                  {:notes "~/Notes"}
                                  :default_workspace "notes"}}}}))

(let [map vim.keymap.set]
  (map :n :<leader>o ":Neorg<CR>" {:desc "Neorg"}))

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

(let [au vim.api.nvim_create_autocmd
      augrp vim.api.nvim_create_augroup
      lo vim.opt_local]
  (au [:FileType] {:group (augrp :NorgConceal {:clear true})
                   :pattern "norg"
                   :callback (λ []
                               (set lo.conceallevel 2)
                               (set lo.foldlevel 99))}))

(let [map vim.keymap.set]
  (map :n :<leader>o ":Neorg<CR>" {:desc "Neorg"}))

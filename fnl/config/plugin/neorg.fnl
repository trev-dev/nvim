(module config.plugin.neorg)

(let [n (require :neorg)]
  (n.setup {:load {:core.defaults {}
                   :core.export {}
                   :core.highlights {}
                   :core.integrations.treesitter {}
                   :core.journal {:config {:strategy "flat"}}
                   :core.mode {}
                   :core.neorgcmd {}
                   :core.completion {:config {:engine "nvim-cmp"}}
                   :core.concealer {:config {:icon_preset "diamond"}}
                   :core.dirman {:config
                                 {:workspaces
                                  {:personal "~/Notes/personal/"
                                   :work "~/Notes/work/"}
                                  :default_workspace "work"}}}}))

(let [au vim.api.nvim_create_autocmd
      augrp vim.api.nvim_create_augroup
      lo vim.opt_local
      bo vim.bo]
  (au [:FileType] {:group (augrp :NorgConceal {:clear true})
                   :pattern "norg"
                   :callback (λ []
                               (set lo.colorcolumn "0")
                               (set lo.conceallevel 2)
                               (set bo.textwidth 80)
                               (set lo.foldlevel 99))}))

(let [map vim.keymap.set]
  (map :n :<leader>o ":Neorg<CR>" {:desc "Neorg"}))

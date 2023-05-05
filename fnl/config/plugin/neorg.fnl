(module config.plugin.neorg)

(let [n (require :neorg)]
  (n.setup {:load {:core.defaults {}
                   :core.export {}
                   :core.highlights {}
                   :core.integrations.treesitter {}
                   :core.integrations.telescope {}
                   :core.journal {:config {:strategy "flat"}}
                   :core.summary {}
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

(let [nc (require :neorg.callbacks)]
  (nc.on_event :core.keybinds.events.enable_keybinds
               (λ [_ keybinds]
                 (keybinds.map_event_to_mode
                   :norg {:i [[:<C-l>
                               :core.integrations.telescope.insert_link]]
                          :n [[:<leader>if
                               :core.integrations.telescope.insert_file_link]
                              [:<leader>il
                               :core.integrations.telescope.insert_link]
                              [:<leader>fh
                               :core.integrations.telescope.search_headings]
                              [:<leader>fo
                               :core.integrations.telescope.find_linkable]]}
                   {:noremap true
                    :silent true}))))

(let [map vim.keymap.set]
  (map :n :<leader>o ":Neorg<CR>" {:desc "Neorg"}))

(module config.plugin.indent-blankline)

(let [ibl (require :ibl)
      colors (require :material.colors)
      set-hl vim.api.nvim_set_hl]
  (set-hl 0 :IblScope {:fg colors.main.paleblue})
  (ibl.setup {:scope {:char "▏"}
              :exclude [:lspinfo
                        :packer
                        :checkhealth
                        :help
                        :txt
                        :md
                        :norg
                        :org
                        :norg]}))

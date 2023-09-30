(module config.plugin.material)

(let [m (require :material)
      colors (require :material.colors)]
  (m.setup {:styles {:comments {:italic true}}
            :plugins [:dap
                      :gitsigns
                      :hop
                      :indent-blankline
                      :neorg
                      :nvim-cmp
                      :nvim-tree
                      :telescope
                      :which-key]
            :disable {:background true}
            :lualine_style "stealth"
            :high_visibility {:darker true}
            :custom_highlights {"@text.reference" {:fg colors.main.darkred}}
            :custom_colors (λ [colors]
                             (set colors.editor.accent colors.main.paleblue))}))

(set vim.g.material_style "darker")
(vim.cmd.colorscheme "material")

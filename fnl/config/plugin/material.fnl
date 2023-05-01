(module config.plugin.material)

(let [m (require :material)]
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
            :custom_colors (λ [colors]
                             (set colors.editor.accent "#89DDFF"))}))

(set vim.g.material_style "darker")
(vim.cmd.colorscheme "material")

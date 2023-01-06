(module tdev.package.material)

(let [(ok? material) (pcall #(require :material))]
  (when ok?
    (fn custom_color_overrides [colors]
      "Override colors in the material theme."
      (set colors.syntax.comments "#F07178"))
    (material.setup {:plugins [:gitsigns :hop :indent-blankline :nvim-cmp
                               :nvim-tree :telescope :which-key]
                     :disable {:background true}
                     :lualine_style "stealth"
                     :custom_colors custom_color_overrides})
    (set vim.g.material_style "darker")
    (vim.cmd "colorscheme material")))

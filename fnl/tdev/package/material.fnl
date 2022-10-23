(module tdev.package.material)

(let [(ok? material) (pcall #(require :material))]
  (when ok?
    (material.setup {:plugins [:gitsigns :hop :indent-blankline :nvim-cmp
                               :nvim-tree :telescope :which-key]
                     :disable {:background true}
                     :lualine_style "stealth"})
    (set vim.g.material_style "darker")
    (vim.cmd "colorscheme material")))

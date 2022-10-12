(module tdev.package.material)

(let [(ok? material) (pcall #(require :material))]
  (when ok?
    (material.setup)
    (set vim.g.material_style "darker")
    (vim.cmd "colorscheme material")))

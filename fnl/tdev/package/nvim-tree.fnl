(module tdev.package.nvim-tree
  {autoload {utils tdev.utils}})

(let [(ok? nvim-tree) (pcall #(require :nvim-tree))]
  (when ok?
    (nvim-tree.setup)
    (utils.map :<C-k>b "NvimTreeToggle")))

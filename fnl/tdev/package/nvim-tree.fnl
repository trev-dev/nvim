(module tdev.package.nvim-tree
  {autoload {utils tdev.utils}})

(let [(ok? nvim-tree) (pcall #(require :nvim-tree))]
  (when ok?
    (nvim-tree.setup {:sync_root_with_cwd true
                      :respect_buf_cwd true
                      :update_focused_file {:enable true :update_root true }})
    (utils.map :<C-k>b "NvimTreeToggle")))

(module tdev.package.nvim-scrollbar
  {autoload {utils tdev.utils}})

;; TODO: Revisit keybindings
(let [(ok? scrollbar) (pcall #(require :scrollbar))]
  (when ok?
    (scrollbar.setup
      {:handlers {:diagnostic true :search true}})))

(module tdev.package.nvim-scrollbar
  {autoload {utils tdev.utils}})

(local config {:handle {:color "#323232"}
               :handlers {:diagnostic true :search true}})

(let [(theme colors) (pcall #(require :material.colors))]
  (when theme
    (tset config :marks {:Search {:color colors.editor.fg}})))

(let [(ok? scrollbar) (pcall #(require :scrollbar))]
  (when ok?
    (scrollbar.setup config)))

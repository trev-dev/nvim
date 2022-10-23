(module tdev.package.lualine)

;; TODO: Re-customize this
(let [(ok? lualine) (pcall #(require :lualine))]
  (when ok?
    (lualine.setup {:options {:globalstatus true :theme "material"}})))

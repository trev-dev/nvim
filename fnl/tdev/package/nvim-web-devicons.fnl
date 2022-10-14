(module tdev.package.nvim-web-devicons
  {autoload {utils tdev.utils}})

(let [(ok? nvim-web-devicons) (pcall #(require :nvim-web-devicons))]
  (when ok?
    (nvim-web-devicons.setup {:override {:fnl {:icon ""
                                               :color "#FFF3D7"
                                               :cterm_color "230"
                                               :name "Fennel"}}})))

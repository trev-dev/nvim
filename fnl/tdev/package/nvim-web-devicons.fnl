(module tdev.package.nvim-web-devicons
  {autoload {utils tdev.utils}})

(let [(ok? nvim-web-devicons) (pcall #(require :nvim-web-devicons))]
  (when ok?
    (nvim-web-devicons.setup)))

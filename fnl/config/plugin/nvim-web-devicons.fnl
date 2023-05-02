(module config.plugin.nvim-web-devicons)

(let [nwd (require :nvim-web-devicons)]
  (nwd.setup {:override {:nim {:icon ""
                               :color "#F3D400"
                               :cterm_color "220"
                               :name "Nim"}}}))

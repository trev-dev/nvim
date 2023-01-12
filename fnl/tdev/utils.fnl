(module tdev.utils
  {autoload {nvim aniseed.nvim
             a aniseed.core}})

(defn map [lhs rhs opts]
  (let [base-map-opts {:noremap true :silent true}
        map-opts (if (a.function? rhs)
                   (a.merge base-map-opts {:callback rhs})
                   base-map-opts)
        cmd (if (a.function? rhs)
              ""
              (a.get opts :plain?)
              rhs
              (.. ":" rhs "<cr>"))]
    (if (a.get opts :local?)
      (nvim.buf_set_keymap (or (. opts :buffer) 0) :n lhs cmd map-opts)
      (nvim.set_keymap :n lhs cmd map-opts))))

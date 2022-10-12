(module tdev.utils
  {autoload {nvim aniseed.nvim
             a aniseed.core}})

;; Borrowed from Olical/magic-kit
;; https://github.com/Olical/magic-kit/blob/main/fnl/magic/util.fnl#L19
(defn map [from to opts]
  (let [map-opts {:noremap true :silent true}
        to (.. ":" to "<cr>")]
    (if (a.get opts :local?)
      (nvim.buf_set_keymap 0 :n from to map-opts)
      (nvim.set_keymap :n from to map-opts))))

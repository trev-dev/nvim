(module tdev.package.mason)

(let [(ok? mason) (pcall #(require :mason))]
  (when ok?
    (mason.setup {:ui {:border "rounded"}})))

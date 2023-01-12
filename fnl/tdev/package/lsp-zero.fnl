(module tdev.package.lsp-zero)

(let [(ok? lsp) (pcall #(require :lsp-zero))]
  (when ok?
    (lsp.preset "recommended")
    (lsp.setup)))

(module tdev.package.gitsigns)

(let [(ok? gitsigns) (pcall #(require :gitsigns))]
  (when ok?
    (gitsigns.setup)))

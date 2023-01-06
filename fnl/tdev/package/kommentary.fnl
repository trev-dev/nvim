(module tdev.package.kommentary)

(let [(ok? kommentary) (pcall #(require :kommentary))]
  (when ok?
    (let [cfg (require :kommentary.config)]
      cfg.use_extended_mappings)))

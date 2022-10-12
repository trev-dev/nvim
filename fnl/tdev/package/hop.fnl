(module tdev.package.hop
  {autoload {utils tdev.utils}})

(let [(ok? hop) (pcall #(require :hop))]
  (when ok?
    (utils.map :<leader>s "HopChar1")
    (hop.setup {:keys "etovxqpdygfblzhckisuran" :case_insensitive false})))

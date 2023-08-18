(module config.plugin.which-key)

(let [wk (require :which-key)]
  (wk.setup {:window {:border "single"}}))

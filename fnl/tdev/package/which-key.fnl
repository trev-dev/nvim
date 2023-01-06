(module tdev.package.which-key)

(let [(ok? which-key) (pcall #(require :which-key))]
  (when ok?
    (which-key.setup
      {:window {:border "single"
                :position "bottom"
                :margin [ 1 0 1 0 ]
                :padding [ 2 2 2 2 ]
                :winblend 0}})))

(module tdev.package.hop)

(let [(ok? hop) (pcall #(require :hop))]
  (when ok?
    (vim.api.nvim_set_keymap "n" "<leader>s" ":HopChar1<CR>"
                              {:noremap true :silent true})
    (hop.setup {:keys "etovxqpdygfblzhckisuran" :case_insensitive false})))

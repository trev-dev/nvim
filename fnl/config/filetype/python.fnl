(module config.filetype.python)

(let [au vim.api.nvim_create_autocmd
      augrp vim.api.nvim_create_augroup]
  (au [:FileType] {:group (augrp :PythonIndent {:clear true})
                   :pattern "python"
                   :callback (λ []
                               (set vim.bo.tabstop 4)
                               (set vim.bo.shiftwidth 4)
                               (set vim.bo.softtabstop 4)
                               (set vim.bo.expandtab true))}))

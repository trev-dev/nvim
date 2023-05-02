(module config.filetype.markdown)

(let [au vim.api.nvim_create_autocmd
      augrp vim.api.nvim_create_augroup
      bo vim.bo
      lo vim.opt_local]
  (au [:FileType] {:group (augrp :MarkdownCustom {:clear true})
                   :pattern "markdown"
                   :callback (λ []
                               (set bo.shiftwidth 2)
                               (set bo.softtabstop 2)
                               (set bo.tabstop 2)
                               (set bo.textwidth 80)
                               (set lo.conceallevel 2)
                               (set lo.colorcolumn "80")
                               (set lo.foldlevel 99))}))

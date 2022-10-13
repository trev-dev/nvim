(module tdev.package.vim-javascript)

(let [autogrp vim.api.nvim_create_augroup
      autocmd vim.api.nvim_create_autocmd]
  (autocmd ["FileType"]
           {:group (autogrp "javascript_folding" {:clear false})
            :pattern "javascript"
            :callback (fn []
                        (set vim.g.javascript_plugin_jsdoc 1)
                        (set vim.g.javascript_plugin_ngdoc 1)
                        (set vim.opt_local.foldmethod "syntax"))}))

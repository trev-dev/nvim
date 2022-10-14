(module tdev.package.lspconfig
  {autoload {utils tdev.utils
             a aniseed.core}})

(fn make-attach-handler [use-lsp-sigs lsp-sigs]
  (fn [client bufnr]
    (let [opts {:local? true :buffer bufnr}]
      (utils.map :<leader>e "lua vim.lsp.buf.definition()" opts)
      (utils.map :<leader>c "lua vim.lsp.buf.declaration()" opts)
      (utils.map :<leader>r "lua vim.lsp.buf.references()" opts)
      (utils.map :<leader>t "lua vim.lsp.buf.type_definition()" opts)
      (utils.map :<leader>i "lua vim.lsp.buf.implementation()" opts)
      (utils.map :<leader>a "lua vim.lsp.buf.code_action()" opts)
      (utils.map :<leader>r "lua vim.lsp.buf.references()" opts)
      (utils.map :<leader>F "lua vim.lsp.buf.format({async = true})" opts)
      (utils.map :K "lua vim.lsp.buf.hover()" opts)
      (utils.map :<C-i> "lua vim.lsp.buf.signature_help()" opts)
      (utils.map :<C-p> "lua vim.diagnostic.goto_prev()" opts)
      (utils.map :<C-n> "lua vim.diagnostic.goto_next()" opts)
      (utils.map :<C-h> "lua vim.diagnostic.open_float()" opts)
      (utils.map :<space>wa "lua vim.lsp.buf.add_workspace_folder()" opts)
      (utils.map :<space>wr "lua vim.lsp.buf.remove_workspace_folder()" opts)
      (utils.map :<space>wl (.. "lua print(vim.inspect"
                                "(vim.lsp.buf.list_workspace_folders()))") opts)
      (utils.map :<space>rn "lua vim.lsp.buf.rename()" opts)
      (when use-lsp-sigs
        (lsp-sigs.on_attach
          {:bind true
           :handler_opts {:border "rounded"}
           :doc_lines 0
           :hint_enable false}
          bufnr)))))

(let [(lspcfg? lspcfg) (pcall #(require :lspconfig))
      (lspsig? lspsig) (pcall #(require :lsp_signature))
      (cnl? cnl) (pcall #(require :cmp_nvim_lsp))]
  (when lspcfg?
    (local capabilities (let [caps (vim.lsp.protocol.make_client_capabilities)]
                          (if cnl?
                            (cnl.update_capabilities caps)
                            caps)))
    (set capabilities.textDocument.completion.completionItem.snippetSupport
         true)
    (let [configs (require :lspconfig.configs)
          languages {:jedi_language_server {}
                     :bashls {}
                     :intelephense {}
                     :tsserver {}
                     :vuels {}
                     :svelte {}
                     :html {}
                     :cssls {}
                     :solargraph {}
                     :theme_check {:cmd ["theme-check-language-server"]}
                     :rnix {}
                     :yamlls {}}]
      (each [lang conf (pairs languages)]
        ((. (. lspcfg lang) :setup)
         (a.merge {:on_attach (make-attach-handler
                                lspsig? lspsig)
                   :capabilities capabilities}
                  conf))))))

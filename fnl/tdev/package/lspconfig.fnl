(module tdev.package.lspconfig
  {autoload {utils tdev.utils
             a aniseed.core}})

(local signs {:Error "»" :Warn "»" :Hint "›" :Info "›"})

(each [t i (pairs signs)]
  (let [hl (.. "DiagnosticSign" t)]
    (vim.fn.sign_define hl {:text i :texthl hl :numhl hl})))

(vim.diagnostic.config {:virtual_text false
                        :signs {:active signs}
                        :update_in_insert true
                        :underline true
                        :severity_sort true
                        :float {:style "minimal"
                                :border "rounded"
                                :source "always"
                                :header ""
                                :prefix ""}})

(fn make-attach-handler [use-lsp-sigs lsp-sigs]
  (fn [_ bufnr]
    (let [opts {:local? true :buffer bufnr}
          buf vim.lsp.buf
          diag vim.lsp.diagnostic
          map utils.map
          (which-key? wk) (pcall #(require "which-key"))]
      (fn inspect-workspace-folders [] (print (vim.inspect
                                                (buf.list_workspace_folders))))
      (map :<localleader>e (fn [] (buf.definition)) opts)
      (map :<localleader>c (fn [] (buf.declaration)) opts)
      (map :<localleader>r (fn [] (buf.references)) opts)
      (map :<localleader>t (fn [] (buf.type_definition)) opts)
      (map :<localleader>i (fn [] (buf.implementation)) opts)
      (map :<localleader>a (fn [] (buf.code_action)) opts)
      (map :<localleader>F (fn [] (buf.format {:async true})) opts)
      (map :<localleader>R (fn [] (buf.rename)) opts)
      (map :<localleader>wa (fn [] (buf.add_workspace_folder)) opts)
      (map :<localleader>wr (fn [] (buf.remove_workspace_folder)) opts)
      (map :<localleader>wl (fn [] (inspect-workspace-folders)) opts)
      (map :<localleader>ws "LspStart" opts)
      (map :<localleader>wr "LspRestart" opts)
      (map :<localleader>wS "LspStop" opts)

      (map :K (fn [] (buf.hover)) opts)
      (map :<C-i> (fn [] (buf.signature_help)) opts)
      (map :<C-p> (fn [] (diag.goto_prev)) opts)
      (map :<C-n> (fn [] (diag.goto_next)) opts)
      (map :<C-h> (fn [] (diag.open_float)) opts)

      (when which-key?
        (wk.register {:name "LSP"
                      :e "Goto Definition"
                      :c "Goto Declaration"
                      :r "Goto References"
                      :t "Goto Type Definition"
                      :i "Goto Implementation"
                      :a "Code Actions"
                      :R "Rename Symbol"
                      :F "Format Selection/Buffer"}
                     {:prefix :<localleader>})
        (wk.register {:w {:name "LSP Workspace"
                          :a "Add Folder"
                          :R "Remove Folder"
                          :l "List Folders"
                          :s "Start"
                          :r "Restart"
                          :S "Stop"}}
                     {:prefix :<localleader>}))

      (when use-lsp-sigs
        (lsp-sigs.on_attach
          {:bind true
           :handler_opts {:border "rounded"}
           :doc_lines 0
           :hint_enable false}
          bufnr)))))

(local php-stubs {:stubs ["wordpress-stubs"]
                  :environment {:includePaths (.. (os.getenv "HOME")
                                                  "/.config/composer"
                                                  "/vendor/php-stubs/")}})

(fn get-intelephense-key []
  (let [keyfile (io.open (.. (os.getenv "HOME")
                              "/Documents/intelephense.txt"))]
    (when keyfile (keyfile:read))))

(local intelephense-config
  {:init_options {:globalStoragePath (.. (os.getenv "HOME")
                                         "/.local/share/intelephense")
                  :licenceKey (get-intelephense-key)}
   :settings {:intelephense (a.merge php-stubs
                                     {:files {:maxSize 2_500_000}})}})

(let [(lspcfg? lspcfg) (pcall #(require :lspconfig))
      (lspsig? lspsig) (pcall #(require :lsp_signature))
      (cnl? cnl) (pcall #(require :cmp_nvim_lsp))]
  (when lspcfg?
    (local capabilities (let [caps (vim.lsp.protocol.make_client_capabilities)]
                          (if cnl?
                            (cnl.default_capabilities caps)
                            caps)))
    (set capabilities.textDocument.completion.completionItem.snippetSupport
         true)
    (let [configs (require :lspconfig.configs)
          languages {:jedi_language_server {}
                     :bashls {}
                     :intelephense intelephense-config
                     :tsserver {}
                     :vuels {}
                     :svelte {}
                     :html {}
                     :cssls {}
                     :solargraph {}
                     :nimls {}
                     :theme_check {:cmd ["theme-check-language-server"]}
                     :rnix {}
                     :yamlls {}}]
      (each [lang conf (pairs languages)]
        ((. (. lspcfg lang) :setup)
         (a.merge {:on_attach (make-attach-handler lspsig? lspsig)
                   :capabilities capabilities}
                  conf))))))

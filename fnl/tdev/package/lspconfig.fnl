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

(local php-stubs {:stubs ["apache" "bcmath" "bz2" "calendar" "com_dotnet"
                          "Core" "ctype" "curl" "date" "dba" "dom" "enchant"
                          "exif" "fileinfo" "filter" "fpm" "ftp" "gd" "hash"
                          "iconv" "imap" "interbase" "intl" "json" "ldap"
                          "libxml" "mbstring" "mcrypt" "meta" "mssql" "mysqli"
                          "oci8" "odbc" "openssl" "pcntl" "pcre" "PDO"
                          "pdo_ibm" "pdo_mysql" "pdo_pgsql" "pdo_sqlite"
                          "pgsql" "Phar" "posix" "pspell" "readline" "recode"
                          "Reflection" "regex" "session" "shmop" "SimpleXML"
                          "snmp" "soap" "sockets" "sodium" "SPL" "sqlite3"
                          "standard" "superglobals" "sybase" "sysvmsg"
                          "sysvsem" "sysvshm" "tidy" "tokenizer" "wddx" "xml"
                          "xmlreader" "xmlrpc" "xmlwriter" "Zend OPcache" "zip"
                          "zlib" "wordpress-stubs"]
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
                            (cnl.update_capabilities caps)
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

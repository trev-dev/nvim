(module config.filetype.javascript)

(let [au vim.api.nvim_create_autocmd
      augrp vim.api.nvim_create_augroup]
  (au [:FileType] {:group (augrp :JavaScriptPrefs {:clear true})
                   :pattern "javascript"
                   :callback (λ []
                               (set vim.opt_local.colorcolumn "120"))})
  (au [:FileType] {:group (augrp :TypeScriptPrefs {:clear true})
                    :pattern "typescript"
                    :callback (λ []
                                (set vim.opt_local.colorcolumn "120"))}))

(local debugger (.. (os.getenv "HOME")
                    "/.local/share.nvim/mason"
                    "/packages/js-debug-adapter/"
                    "js-debug-adapter"))

(let [dap (require :dap-vscode-js)]
  (dap.setup {:adaptors [:pwa-node
                         :pwa-chrome
                         :pwa-msedge
                         :node-terminal
                         :pwa-extensionHost]}))

(let [langs [:typescript :javascript]
      d (require :dap)]
  (each [_ l (ipairs langs)]
    (tset d.configurations l [{:type "pwa-node"
                               :request "launch"
                               :name "Launch file"
                               :program "${file}"
                               :cwd "${workspaceFolder}"}
                              {:type "pwa-node"
                               :request "attach"
                               :name "Attach"
                               :processId (let [utils (require :dap.utils)]
                                            utils.pick_process)
                               :cwd "${workspaceFolder}"}])))

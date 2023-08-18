(module config.plugin.nvim-lspconfig
  {autoload {u config.util}})

(let [m (require :mason)
      mlsp (require :mason-lspconfig)]
  (m.setup {:ui {:border "single"}})
  (mlsp.setup))

(local lspconfig (require :lspconfig))
(local server-configs [[:bashls {}]
                       [:cssls {}]
                       [:html {}]
                       [:jedi_language_server {}]
                       [:hls {}]
                       [:rnix {}]
                       [:jsonls {}]
                       [:nimls {}]
                       [:svelte {}]
                       [:tsserver {}]
                       [:eslint {}]
                       [:volar {:filetypes [:vue]}]
                       [:yamlls {}]])

(each [_ config (ipairs server-configs)]
  (let [[name options] config]
    ((. (. lspconfig name) :setup) options)))

(let [signs {:Error "»" :Warn "»" :Hint "›" :Info "›"}]
  (each [k v (pairs signs)]
    (let [hl (.. "DiagnosticSign" k)]
      (vim.fn.sign_define hl {:text v :texthl hl :numhl hl})))
  (vim.diagnostic.config {:signs {:active signs}
                          :update_in_insert true
                          :underline true
                          :severity_sort true
                          :float {:border "single"
                                  :source "always"
                                  :header ""
                                  :prefix ""}}))

(let [w (require "lspconfig.ui.windows")]
  (set w.default_options.border "single"))

(λ set-lsp-mappings [event]
  (let [map vim.keymap.set
        buf vim.lsp.buf
        opts {:buffer event.buf}
        wk (require :which-key)]
    (λ with-desc [desc] {:buffer buff : desc})
    (tset (. vim.bo event.buf) :omnifunc "v:lua.vim.lsp.omnifunc")
    (map :n :H vim.diagnostic.open_float)
    (map :n "[d" vim.diagnostic.goto_prev {:desc "previous diagnostc"})
    (map :n "]d" vim.diagnostic.goto_next {:desc "next diagnostc"})
    (map :n :gD buf.declaration opts {:desc "goto [D]iagnostic"})
    (map :n :gd buf.definition opts {:desc "goto [d]efinition"})
    (map :n :K buf.hover opts)
    (map :n :gi buf.implementation opts {:desc "goto [i]mplementation"})
    (map :n :<C-k> buf.signature_help opts)

    (wk.register {:w {:name "lsp [w]orkspace"} :prefix :<localleader>})
    (map :n :<localleader>wa buf.add_workspace_folder (with-desc
                                                        "[a]dd folder"))
    (map :n :<localleader>wr buf.remove_workspace_folder (with-desc
                                                           "[r]emove folder"))
    (map :n :<localleader>wl (λ [] (vim.inspect (buf.list_workspace_folders)))
         (with-desc "[l]ist folders"))
    (map :n :<localleader>D buf.type_definition (with-desc
                                                  "goto type [D]efinition"))
    (map :n :<localleader>r buf.rename (with-desc "[r]ename symbol"))
    (map [:n :v] :<localleader>c buf.code_action (with-desc "[c]ode action"))
    (map :n :gr buf.references (with-desc "goto [r]eferences"))
    (map :n :<localleader>F (λ [] (buf.format {:async true}))
         (with-desc "[F]ormat buffer"))
    (map :n :<leader>fs ":Telescope lsp_document_symbols<CR>" opts)
    (map :n :<leader>fws ":Telescope lsp_workspace_symbols<CR>" opts)))

(let [au vim.api.nvim_create_autocmd
      group (vim.api.nvim_create_augroup "UserLspConfig" {})]
  (au "LspAttach" {:group group
                   :callback set-lsp-mappings}))

(tset vim.lsp.handlers :textDocument/hover
      (vim.lsp.with vim.lsp.handlers.hover {:border "single"}))
(tset vim.lsp.handlers :textDocument/signatureHelp
      (vim.lsp.with vim.lsp.handlers.signature_help {:border "rounded"}))

(let [lsp-sig (require :lsp_signature)]
  (lsp-sig.setup {:bind true
                  :handler_opts {:border "single"}
                  :doc_lines 0
                  :hint_enable false}))

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
        opts {:buffer event.buf}]
    (tset (. vim.bo event.buf) :omnifunc "v:lua.vim.lsp.omnifunc")
    (map :n :gD buf.declaration opts)
    (map :n :gd buf.definition opts)
    (map :n :K buf.hover opts)
    (map :n :gi buf.implementation opts)
    (map :n :<C-k> buf.signature_help opts)
    (map :n :<localleader>wa buf.add_workspace_folder opts)
    (map :n :<localleader>wr buf.remove_workspace_folder opts)
    (map :n :<localleader>wl (λ [] (vim.inspect (buf.list_workspace_folders))) opts)
    (map :n :<localleader>D buf.type_definition opts)
    (map :n :<localleader>rn buf.rename opts)
    (map [:n :v] :<localleader>ca buf.code_action opts)
    (map :n :gr buf.references opts)
    (map :n :<localleader>F (λ [] (buf.format {:async true})) opts)))

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

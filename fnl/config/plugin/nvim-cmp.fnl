(module config.plugin.nvim-cmp)

(local cmp (require :cmp))
(local snip (require :luasnip))
(local autopairs (require :nvim-autopairs.completion.cmp))
(local dap (require :cmp_dap))

(cmp.setup {:snippet (λ [args] (snip.lsp_expand args.body))
            :mapping {:<C-Space> (cmp.mapping (cmp.mapping.complete) [:i :c])
                      :<C-b> (cmp.mapping (cmp.mapping.scroll_docs (- 4))
                                          [:i :c])
                      :<C-e> (cmp.mapping {:c (cmp.mapping.close)
                                           :i (cmp.mapping.abort)})
                      :<C-f> (cmp.mapping (cmp.mapping.scroll_docs 4) [:i :c])
                      :<C-n> (cmp.mapping (λ [fallback]
                                            (if (cmp.visible)
                                              (cmp.select_next_item)
                                              (fallback)))
                                          [:i :s :c])
                      :<C-p> (cmp.mapping (λ [fallback]
                                            (if (cmp.visible)
                                              (cmp.select_prev_item)
                                              (fallback)))
                                          [:i :s :c])
                      :<C-y> cmp.config.disable
                      :<CR> (cmp.mapping.confirm {:select true})}
            :sources (cmp.config.sources [{:name :nvim_lsp}
                                          {:name :vsnip}
                                          {:name :path}]
                                         [{:name :buffer}])
            :enabled (λ [] (or (not= (vim.api.nvim_buf_get_option 0 :buftype)
                                     :prompt)
                               (dap.is_dap_buffer)))}

           (cmp.setup.filetype :norg {:sources (cmp.config.sources
                                                  [{:name :neorg}]
                                                  [{:name :buffer}])})

           (cmp.setup.cmdline [:/ :?] {:mapping (cmp.mapping.preset.cmdline)
                                       :sources [{:name :buffer}]})

           (cmp.setup.cmdline :: {:mapping (cmp.mapping.preset.cmdline)
                                  :sources (cmp.config.sources
                                             [{:name :path}]
                                             [{:name :cmdline}])})

           (cmp.setup.filetype [:dap-repl :dapui_watches :dapui_hover]
                               {:sources [{:name :dap}]}))

(cmp.event:on :confirm_done (autopairs.on_confirm_done))

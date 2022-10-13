(module tdev.package.cmp)

(let [(ok? cmp) (pcall #(require :cmp))]
  (when ok?
    (set vim.o.completeopt "menu,menuone,noselect")
    (set vim.o.wildmenu false)
    (cmp.setup
      {:snippet {:expand (fn [args]
                           ((. vim.fn "vsnip#anonymous") args.body))}
       :mapping {:<C-b> (cmp.mapping (cmp.mapping.scroll_docs (- 4)) ["i" "c"])
                 :<C-f> (cmp.mapping (cmp.mapping.scroll_docs 4) ["i" "c"])
                 :<C-Space> (cmp.mapping (cmp.mapping.complete) ["i" "c"])
                 :<C-y> cmp.config.disable
                 :<C-e> (cmp.mapping {:i (cmp.mapping.abort)
                                      :c (cmp.mapping.close)})
                 :<CR> (cmp.mapping.confirm {:select true})
                 :<C-n> (cmp.mapping
                          (lambda [fallback]
                            (if (cmp.visible)
                              (cmp.select_next_item)
                              (fallback)))
                          ["i" "s" "c"])
                 :<C-p> (cmp.mapping
                            (lambda [fallback]
                              (if (cmp.visible)
                                (cmp.select_next_item)
                                (fallback)))
                            ["i" "s" "c"])}
       :sources (cmp.config.sources
                  [{:name "nvim_lsp" :max_item_count 5}
                   {:name "conjure" :max_item_count 5}
                   {:name "vsnip" :max_item_count 5}
                   {:name "path" :max_item_count 5}
                   {:name "orgmode"}]
                  [{:name "buffer"}])
       :window {:completion (cmp.config.window.bordered)
                :documentation (cmp.config.window.bordered)}})
    (cmp.setup.filetype "gitcommit"
                        {:sources (cmp.config.sources
                                    [{:name "cmp_git"}]
                                    [{:name "buffer"}])})
    (cmp.setup.cmdline "/"
                       {:sources (cmp.config.sources
                                   [{:name "buffer" :max_item_count 10}])})
    (cmp.setup.cmdline ":"
                       {:sources (cmp.config.sources
                                   [{:name "path" :max_item_count 10}]
                                   [{:name "cmdline" :max_item_count 10}])})))

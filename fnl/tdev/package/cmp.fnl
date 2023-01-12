(module tdev.package.cmp)

(let [(ok? cmp) (pcall #(require :cmp))]
  (when ok?
    (set vim.o.completeopt "menu,menuone,noselect")
    (set vim.o.wildmenu false)
    (local cmap cmp.mapping)
    (cmp.setup
      {:snippet {:expand (fn [args]
                           ((. vim.fn "vsnip#anonymous") args.body))}
       :mapping {:<C-b> (cmap (cmap.scroll_docs -4 [:i :c]))
                 :<C-f> (cmap (cmap.scroll_docs 4 [:i :c]))
                 :<C-Space> (cmap (cmap.complete [:i :c]))
                 :<C-y> cmp.config.disable
                 :<C-e> (cmap {:i (cmap.abort)
                               :c (cmap.abort)})
                 :<CR> (cmap.confirm {:select true})
                 :<C-n> (cmap (fn [fallback]
                                (if (cmp.visible)
                                  (cmp.select_next_item)
                                  (fallback)))
                              [:i :s :c])
                 :<C-p> (cmap (fn [fallback]
                                (if (cmp.visible)
                                  (cmp.select_prev_item)
                                  (fallback)))
                              [:i :s :c])}
       :sources (cmp.config.sources
                  [{:name "conjure" :max_item_count 10}
                   {:name "nvim_lsp" :max_item_count 10}
                   {:name "vsnip" :max_item_count 10}
                   {:name "path" :max_item_count 10}]
                  [{:name "buffer"}])})
    (cmp.setup.filetype "gitcommit"
                        {:sources (cmp.config.sources
                                    [{:name "cmp_git"}]
                                    [{:name "buffer"}])})
    (cmp.setup.cmdline [:/ :?]
                       {:mapping (cmap.preset.cmdline)
                        :sources (cmp.config.sources
                                   [{:name "buffer" :max_item_count 10}])})
    (cmp.setup.cmdline ::
                       {:sources (cmp.config.sources
                                   [{:name "path" :max_item_count 10}]
                                   [{:name "cmdline" :max_item_count 10}])})))

(module tdev.package.cmp)

(let [(ok? cmp) (pcall #(require :cmp))]
  (when ok?
    (set vim.o.completeopt "menu,menuone,noselect")
    (set vim.o.wildmenu false)
    (cmp.setup
      {:snippet {:expand (fn [args]
                           ((. vim.fn "vsnip#anonymous") args.body))}
       :mapping (cmp.mapping.preset.insert
                  {:<C-b> (cmp.mapping.scroll_docs -4)
                   :<C-f> (cmp.mapping.scroll_docs 4)
                   :<C-Space> (cmp.mapping.complete)
                   :<C-e> (cmp.mapping.abort)
                   :<CR> (cmp.mapping.confirm {:select true})})
       :sources (cmp.config.sources
                  [{:name "nvim_lsp" :max_item_count 5}
                   {:name "conjure" :max_item_count 5}
                   {:name "vsnip" :max_item_count 5}
                   {:name "path" :max_item_count 5}
                   {:name "orgmode"}]
                  [{:name "buffer"}])})
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

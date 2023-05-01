(module config.plugin.nvim-treesitter)

(fn disable [lang buf]
  (if (= lang "help") true
      (let [max_filesize (* 100 1024)
            (fs stats) (pcall vim.loop.fs_stat (vim.api.nvim_buf_get_name buf))]
        (and fs stats (> stats.size max_filesize))) true
      false))

(let [cfgs (require "nvim-treesitter.configs")]
  (cfgs.setup {:ensure_installed [:bash
                                  :clojure
                                  :css
                                  :fennel
                                  :html
                                  :java
                                  :javascript
                                  :json
                                  :markdown
                                  :markdown_inline
                                  :lua
                                  :nix
                                  :php
                                  :python
                                  :scheme
                                  :svelte
                                  :toml
                                  :typescript
                                  :vim
                                  :vue
                                  :yaml]
               :sync_install false
               :indent {:enable true :disable [:python]}
               :highlight {:enable true :disable disable}}))

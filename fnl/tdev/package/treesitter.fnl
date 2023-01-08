(module tdev.package.treesitter)

(fn disable_on_huge_file [lang buf]
  (let [max (* 100 1024)
        (fs stats) (pcall
                     #(vim.loop.fs_stat (vim.api.nvim_buf_get_name buf)))]
    (or (= lang "help")
        (and fs stats (> stats.size max)))))

(let [(ok? treesitter) (pcall #(require :nvim-treesitter))
      (org? orgmode) (pcall #(require :orgmode))]
  (when ok?
    (when org? (orgmode.setup_ts_grammar))
    (let [parsers (require :nvim-treesitter.parsers)]
      (parsers.get_parser_configs))
    (let [cnfgs (require :nvim-treesitter.configs)]
      (cnfgs.setup
        {:ensure_installed ["bash" "css" "commonlisp" "clojure" "fennel" "html"
                            "javascript" "json" "lua" "org" "markdown" "nix"
                            "php" "python" "scheme" "toml" "typescript" "vim"
                            "yaml" "gitcommit" "git_rebase" "gitignore"
                            "gitattributes"]
         :sync_install false
         :highlight {:enable true
                     :disable disable_on_huge_file
                     :additional_vim_regex_highlighting ["org"]}}))))

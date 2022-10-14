(module tdev.package.treesitter)

(let [(ok? treesitter) (pcall #(require :nvim-treesitter))
      (org? orgmode) (pcall #(require :orgmode))]
  (when ok?
    (when org? (orgmode.setup_ts_grammar))
    (let [parsers (require :nvim-treesitter.parsers)]
      (parsers.get_parser_configs))
    (let [cnfgs (require :nvim-treesitter.configs)]
      (cnfgs.setup
        {:ensure_installed ["bash" "css" "commonlisp" "fennel" "html"
                            "javascript" "json" "lua" "org" "markdown" "nix"
                            "php" "python" "scheme" "toml" "typescript" "vim"
                            "yaml"]
         :sync_install false
         :highlight {:enable true
                     :disable ["help"]
                     :additional_vim_regex_highlighting ["org"]}}))))

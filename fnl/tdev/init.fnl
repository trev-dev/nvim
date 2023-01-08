;; vim: fdm=marker:fmr=<<,>>
(module tdev.init
  {autoload {packages tdev.packages
             utils tdev.utils}})

;; << General Neovim Settings
(let [o  vim.o
      wo vim.wo
      bo vim.bo
      g  vim.g]

  ;; Global
  (set o.mouse "a")
  (set o.termguicolors true)
  (set o.listchars "trail:~")
  (set o.list true)
  (set o.expandtab true)
  (set o.shiftwidth 2)
  (set o.softtabstop 2)
  (set o.tabstop 2)
  (set o.lbr true)
  (set o.redrawtime 10000)
  (set o.clipboard "unnamedplus")
  (set o.guifont "Source Code Pro:h11")

  ;; Window
  (set wo.breakindent true)
  (set wo.colorcolumn "80")
  (set wo.linebreak true)
  (set wo.number true)
  (set wo.relativenumber true)

  (set g.html_indent_script1 "zero")
  (set g.html_indent_style1 "zero"))
;; >>

;; << General Keybinds

(set vim.g.mapleader " ")
(set vim.g.maplocalleader ",")

(fn toggle-whitespace []
  (let [listchars vim.o.listchars
        all-chars "eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣"
        trailing-chars "tab:>·,trail:~"]
    (set vim.o.listchars (if (= listchars all-chars)
                           trailing-chars
                           all-chars))))

(utils.map "<leader>l" "ls")
(utils.map "<leader>a" "blast")
(utils.map "<leader>]" "bn!")
(utils.map "<leader>[" "bp!")
(utils.map "<leader>bd" "bd")
(utils.map "<leader>w" toggle-whitespace)
(utils.map "<leader>r" "set wrap!")

;; >>

;; << Autocommands

(let [autogrp vim.api.nvim_create_augroup
      autocmd vim.api.nvim_create_autocmd
      wo vim.wo
      bo vim.bo
      lo vim.opt_local]

  (let [relative_toggle (autogrp "RelativeNumToggle" {:clear true})]
    (autocmd [:BufEnter :FocusGained :InsertLeave]
             {:group relative_toggle
              :pattern "*"
              :callback (fn []
                          (when wo.number
                            (set wo.relativenumber true)))})
    (autocmd [:BufLeave :FocusLost :InsertEnter]
             {:group relative_toggle
              :pattern "*"
              :callback (fn [] (set wo.relativenumber false))}))
  (autocmd [:BufWrite]
           {:pattern "/home/trev/.config/nvim/*"
            :callback (fn []
                        ((. (require "packer") :compile))
                        (print "Packer Compiled"))})

  (fn highlight-yanked []
    (vim.highlight.on_yank {:higroup :Visual
                            :timeout 350}))
  (autocmd [:TextYankPost]
           {:group (autogrp "HighlightYank" {})
            :pattern "*"
            :callback highlight-yanked})

  ;; Filetype specific
  (autocmd [:FileType]
           {:group (autogrp "PythonIndentContext" {:clear true})
            :pattern "python"
            :callback (fn []
                        (set bo.tabstop 4)
                        (set bo.shiftwidth 4)
                        (set bo.softtabstop 4)
                        (set bo.expandtab true))})

  (autocmd [:BufEnter]
           {:group (autogrp "FancyDocConceal" {:clear true})
            :pattern ["*.md" "*.markdown" "*.org"]
            :callback (lambda []
                        (set lo.conceallevel 2)
                        (set lo.concealcursor "nc"))})

  (let [(ok? tt) (pcall #(require :toggleterm.terminal))]
    (when ok?
      (fn make-nim-term [opt]
        (tt.Terminal:new {:cmd (.. "nim "
                                   opt " "
                                   (vim.api.nvim_buf_get_name 0))
                          :hidden true
                          :close_on_exit false}))
      (fn nim-run-buffer []
        (let [term (make-nim-term "r")]
          (term:toggle)))
      (fn nim-compile-buffer []
        (let [term (make-nim-term "c")]
          (term:toggle)))
      (fn nim-format-buffer []
        (vim.cmd
          (.. "!nimpretty "
              (vim.api.nvim_buf_get_name 0))))
      (fn setup-nim-context []
        (utils.map :<localleader>cr nim-run-buffer {:local? true})
        (utils.map :<localleader>cb nim-compile-buffer {:local? true})
        (utils.map :<localleader>bf nim-format-buffer {:local? true}))

      (autocmd [:FileType]
               {:group (autogrp "NimContext" {:clear true})
                :pattern "nim"
                :callback setup-nim-context}))))

;; >>

;; << Package configurations

(packages.use
  ;; Hard dependencies
  :wbthomason/packer.nvim {:mod :packer}
  :Olical/aniseed {}
  :Olical/conjure {}

  ;; Theming
  :nvim-tree/nvim-web-devicons {:mod :nvim-web-devicons}
  :marko-cerovac/material.nvim {:mod :material}

  ;; Utilities
  :Olical/nvim-local-fennel {}
  :godlygeek/tabular {}
  :jiangmiao/auto-pairs {}
  :markonm/traces.vim {}
  :phaazon/hop.nvim {:mod :hop :branch "v1"}
  :akinsho/toggleterm.nvim {:mod :toggleterm}
  :mattn/emmet-vim {:config
                    (fn [] (set vim.g.user_emmet_leader_key "<C-k>"))}
  :norcalli/nvim-colorizer.lua {:mod :colorizer}
  :lewis6991/gitsigns.nvim {:mod :gitsigns
                            :requires [[:nvim-lua/plenary.nvim]]}
  :tpope/vim-fugitive {}
  :ahmedkhalf/project.nvim {:mod :project-nvim}
  :nvim-telescope/telescope.nvim {:requires [[:nvim-lua/popup.nvim]
                                             [:nvim-lua/plenary.nvim]]}
  :nvim-telescope/telescope-project.nvim {:mod :telescope}
  :nvim-tree/nvim-tree.lua {:mod :nvim-tree
                             :requires [[:nvim-tree/nvim-web-devicons]]}
  :tpope/vim-surround {}
  :akinsho/bufferline.nvim {:mod :bufferline}
  :b3nj5m1n/kommentary {:mod :kommentary}
  :nvim-lualine/lualine.nvim {:mod :lualine
                              :requires [[:nvim-tree/nvim-web-devicons]]}
  :folke/todo-comments.nvim {:mod :todo-comments
                             :requires [[:nvim-lua/plenary.nvim]]}
  :nvim-treesitter/nvim-treesitter {:mod :treesitter :run ":TSUpdate"}
  :nvim-orgmode/orgmode {:mod :orgmode}
  :lukas-reineke/indent-blankline.nvim {:mod :indent-blankline}
  :mickael-menu/zk-nvim {:mod :zk}
  :jakewvincent/mkdnflow.nvim {:mod :mkdnflow}
  :petertriho/nvim-scrollbar {:mod :nvim-scrollbar
                              :requires [[:kevinhwang91/nvim-hlslens]]}
  :folke/which-key.nvim {:mod :which-key}
  :jamessan/vim-gnupg {}
  :Shatur/neovim-session-manager {:mod :session-manager
                                  :requires :nvim-lua/plenary.nvim}

  ;; LSP
  :ray-x/lsp_signature.nvim {}
  :neovim/nvim-lspconfig {:mod :lspconfig}
  :williamboman/mason.nvim {:mod :mason}

  ;; Completions
  :hrsh7th/vim-vsnip {}
  :hrsh7th/vim-vsnip-integ {}
  :hrsh7th/cmp-nvim-lsp {}
  :hrsh7th/cmp-buffer {}
  :hrsh7th/cmp-path {}
  :hrsh7th/cmp-cmdline {}
  :hrsh7th/cmp-vsnip {}
  :PaterJason/cmp-conjure {}
  :hrsh7th/nvim-cmp {:mod :cmp}
  :rafamadriz/friendly-snippets {}

  ;; Syntax
  :zah/nim.vim {}
  :romainl/vim-cool {}
  :dhruvasagar/vim-table-mode {}
  :ledger/vim-ledger {}
  :pangloss/vim-javascript {})
;; >>

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

(var all-chars "eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣")
(var trailing-chars "trail:~")

(global _TOGGLE_WHITESPACE
  (fn []
    (let [listchars vim.o.listchars]
      (set vim.o.listchars (if (= listchars all-chars)
                             trailing-chars
                             all-chars)))))

(utils.map "<leader>l" "ls")
(utils.map "<leader>a" "blast")
(utils.map "<leader>]" "bn!")
(utils.map "<leader>[" "bp!")
(utils.map "<leader>bd" "bd")
(utils.map "<leader>w" "lua _TOGGLE_WHITESPACE()")
(utils.map "<leader>r" "set wrap!")

;; >>

;; << Autocommands

(let [create_augroup vim.api.nvim_create_augroup
      autocmd vim.api.nvim_create_autocmd
      wo vim.wo
      bo vim.bo
      lo vim.opt_local]

  (let [relative_toggle (create_augroup "RelativeNumToggle" {:clear true})]
    (autocmd ["BufEnter" "FocusGained" "InsertLeave"]
             {:group relative_toggle
              :pattern "*"
              :callback (lambda []
                          (when wo.number
                            (set wo.relativenumber true)))})
    (autocmd ["BufLeave" "FocusLost" "InsertEnter"]
             {:group relative_toggle
              :pattern "*"
              :callback (fn [] (set wo.relativenumber false))}))

  ;; Filetype specific indentation
  (autocmd ["FileType"]
           {:group (create_augroup "PythonIndentContext" {:clear true})
            :pattern "python"
            :callback (lambda []
                        (set bo.tabstop 4)
                        (set bo.shiftwidth 4)
                        (set bo.softtabstop 4)
                        (set bo.expandtab true))})

  ;; Fancy conceals for document files
  (autocmd ["BufEnter"]
           {:pattern ["*.md" "*.markdown" "*.org"]
            :callback (lambda []
                        (set lo.conceallevel 2)
                        (set lo.concealcursor "nc"))})

  ;; TODO: Maybe add packer autocommand
  )
;; >>

;; << Package configurations

(packages.use
  :wbthomason/packer.nvim {}
  :Olical/aniseed {}
  :Olical/conjure {}
  :Olical/nvim-local-fennel {}
  :nvim-tree/nvim-web-devicons {:mod :nvim-web-devicons}
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

  :ray-x/lsp_signature.nvim {}
  :neovim/nvim-lspconfig {:mod :lspconfig}
  :williamboman/mason.nvim {:mod :mason}

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

  :prettier/vim-prettier {:run "yarn install"}
  :folke/which-key.nvim {:mod :which-key}

  :romainl/vim-cool {}
  :dhruvasagar/vim-table-mode {}
  :trev-dev/vim-shopify {}
  :ledger/vim-ledger {}
  :pangloss/vim-javascript {}
  :alaviss/nim.nvim {}

  :marko-cerovac/material.nvim {:mod :material})
;; >>

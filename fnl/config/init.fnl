(module config.init
  {autoload {plugin config.plugin
             util config.util}})

;;; General Neovim Settings
(let [o  vim.o
      wo vim.wo
      bo vim.bo
      g  vim.g]

  ;; Global
  (set o.mouse "a")
  (set o.termguicolors true)
  (set o.listchars "tab:>·,trail:~")
  (set o.list true)
  (set o.expandtab true)
  (set o.shiftwidth 2)
  (set o.softtabstop 2)
  (set o.tabstop 2)
  (set o.lbr true)
  (set o.redrawtime 10000)
  (set o.clipboard "unnamedplus")
  (set o.guifont "FiraCode Nerd Font 12")

  ;; Window
  (set wo.breakindent true)
  (set wo.colorcolumn "80")
  (set wo.linebreak true)
  (set wo.relativenumber true)
  (set wo.signcolumn "yes")

  (set g.mapleader " ")
  (set g.maplocalleader ",")
  (set g.html_indent_script1 "zero")
  (set g.html_indent_style1 "zero")
  (set g.loaded_netrw 1)
  (set g.loaded_netrwPlugin 1))

(let [au vim.api.nvim_create_autocmd
      augrp vim.api.nvim_create_augroup]
  (au [:TextYankPost] {:group (augrp :HighlightYank {:clear true})
                       :pattern "*"
                       :callback (λ [] (vim.highlight.on_yank
                                         {:group :Visual
                                          :timeout 350}))}))

(vim.keymap.set :n :<leader>l ":noh<CR>" {:desc "clear search highlights"})

;;; Plugins
(plugin.use
  ;; Utils
  :Olical/aniseed {}
  :Olical/conjure {}
  :Olical/nvim-local-fennel {}
  :akinsho/toggleterm.nvim {:mod :toggleterm}
  :folke/todo-comments.nvim {:requires [[:nvim-lua/plenary.nvim]]
                             :mod :todo-comments}
  :phaazon/hop.nvim {:branch "v2" :mod :hop}
  :kristijanhusak/vim-dadbod-ui {:mod :vim-dadbod
                                 :requires [[:tpope/vim-dadbod]]}
  :lewis6991/gitsigns.nvim {:mod :gitsigns}
  :lukas-reineke/indent-blankline.nvim {:mod :indent-blankline}
  :mattn/emmet-vim {:mod :emmet-vim}
  :norcalli/nvim-colorizer.lua {:mod :nvim-colorizer}
  :nvim-telescope/telescope.nvim {:branch "0.1.x"
                                  :requires
                                  [[:nvim-lua/plenary.nvim]
                                   [:nvim-telescope/telescope-ui-select.nvim]]
                                  :mod :telescope}
  :nvim-tree/nvim-tree.lua {:mod :nvim-tree}
  :nvim-tree/nvim-web-devicons {:mod :nvim-web-devicons}
  :nvim-treesitter/nvim-treesitter {:mod :nvim-treesitter}
  :nvim-neorg/neorg {:mod :neorg
                     :requires [[:nvim-lua/plenary.nvim]]}
  :tpope/vim-commentary {}
  :tpope/vim-fugitive {}
  :tpope/vim-obsession {}
  :tpope/vim-repeat {}
  :tpope/vim-surround {}
  :wbthomason/packer.nvim {}
  :windwp/nvim-autopairs {:mod :nvim-autopairs}
  :folke/which-key.nvim {}
  :jamessan/vim-gnupg {}
  :FooSoft/vim-argwrap {:mod :vim-argwrap}

  ;; LSP
  :williamboman/mason.nvim {:requires [[:williamboman/mason-lspconfig]]
                            :run ":MasonUpdate"}
  :neovim/nvim-lspconfig {:requires [[:ray-x/lsp_signature.nvim]]
                          :mod :nvim-lspconfig}
  :mfussenegger/nvim-jdtls {}

  ;; Completions
  :hrsh7th/nvim-cmp {:mod :nvim-cmp}
  :hrsh7th/cmp-nvim-lsp {}
  :hrsh7th/cmp-buffer {}
  :hrsh7th/cmp-path {}
  :hrsh7th/cmp-cmdline {}
  :hrsh7th/cmp-vsnip {}
  :L3MON4D3/LuaSnip {}
  :saadparwaiz1/cmp_luasnip {}
  :rafamadriz/friendly-snippets {}
  :rcarriga/nvim-dap-ui {:mod :nvim-dap
                         :requires [[:mfussenegger/nvim-dap]
                                    [:rcarriga/cmp-dap]]}

  ;; Theme
  :nvim-lualine/lualine.nvim {:mod :lualine}
  :marko-cerovac/material.nvim {:mod :material})

;;; Autoloads
;; Mostly filetype specific settings
(let [filetypes [:java
                 :markdown
                 :python]]
  (each [_ ft (ipairs filetypes)]
    (util.safe-require (.. "config.filetype." ft))))

;; vim: fdm=marker:fmr=<<,>>
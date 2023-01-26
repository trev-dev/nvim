local utils = require("utils")

utils.ensure("wbthomason", "packer.nvim")

utils.safe_require('vim-settings')
utils.safe_require('autocommands')
utils.safe_require('vim-bindings')

-- Packer init & package configurations.
local packages = require("packages")

packages.use({
  "wbthomason/packer.nvim",

  -- Utilities
  {"kyazdani42/nvim-web-devicons", mod = "nvim-web-devicons"},
  {"Vonr/align.nvim", mod = "align"},
  "jamessan/vim-gnupg",
  "jiangmiao/auto-pairs",
  "markonm/traces.vim",
  "tpope/vim-surround",
  "tpope/vim-fugitive",
  "tpope/vim-sleuth",
  "dhruvasagar/vim-table-mode",
  {"phaazon/hop.nvim", mod = "hop", branch = "v1" },
  {"akinsho/toggleterm.nvim", mod = "toggleterm"},
  {"nvim-telescope/telescope.nvim", mod = "telescope",
  requires = {
    {"nvim-lua/popup.nvim"},
    {"nvim-lua/plenary.nvim"},
    {"nvim-telescope/telescope-ui-select.nvim"}}
  },
  {"mattn/emmet-vim", mod = "emmet"},
  {"norcalli/nvim-colorizer.lua", mod = "nvim-colorizer"},
  {"lewis6991/gitsigns.nvim", mod = "gitsigns",
  requires = { "nvim-lua/plenary.nvim" }},
  {"kyazdani42/nvim-tree.lua", mod = "nvim-tree",
  requires = { "kyazdani42/nvim-web-devicons" }},
  {"akinsho/bufferline.nvim", mod = "bufferline"},
  "b3nj5m1n/kommentary",
  {"nvim-lualine/lualine.nvim", mod = "lualine",
  requires = { "kyazdani42/nvim-web-devicons", opt = true }},
  {"folke/todo-comments.nvim", mod = "todo-comments",
  requires = "nvim-lua/plenary.nvim"},
  {"nvim-treesitter/nvim-treesitter", mod = "treesitter"},
  {"lukas-reineke/indent-blankline.nvim", mod = "indent-blankline"},
  {"mickael-menu/zk-nvim", mod = "zk"},
  {"jakewvincent/mkdnflow.nvim", mod = "mkdnflow"},
  {"petertriho/nvim-scrollbar", mod = "nvim-scrollbar"},
  {"kevinhwang91/nvim-hlslens", mod = "nvim-hlslns"},
  {"folke/which-key.nvim", mod = "which-key"},
  {"Shatur/neovim-session-manager", mod = "session-manager",
  requires = "nvim-lua/plenary.nvim"},

  -- LSP & Completion
  "ray-x/lsp_signature.nvim",
  {"neovim/nvim-lspconfig", mod = "lspconfig"},
  {"williamboman/mason.nvim", mod = "mason"},
  {"hrsh7th/nvim-cmp", mod = "nvim-cmp"},
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  "hrsh7th/cmp-vsnip",
  "hrsh7th/vim-vsnip",
  "hrsh7th/vim-vsnip-integ",
  "rafamadriz/friendly-snippets",

  -- Additional Syntax Support
  "ledger/vim-ledger",
  {"kkoomen/vim-doge", run = ":call doge#install()"},
  "pangloss/vim-javascript",
  "zah/nim.vim",

  -- Theme
  {"marko-cerovac/material.nvim", mod = "material"},
})

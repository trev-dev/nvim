return {
  -- Editor
  "kyazdani42/nvim-web-devicons",
  "jamessan/vim-gnupg",
  "jiangmiao/auto-pairs",
  "markonm/traces.vim",
  "tpope/vim-surround",
  "tpope/vim-fugitive",
  "tpope/vim-rhubarb",
  "tpope/vim-sleuth",
  "tpope/vim-obsession",
  {"kristijanhusak/vim-dadbod-ui", dependencies = "tpope/vim-dadbod"},
  "dhruvasagar/vim-table-mode",
  {"phaazon/hop.nvim", branch = "v1" },
  {"akinsho/toggleterm.nvim"},
  {"nvim-telescope/telescope.nvim",
    dependencies = {
      {"nvim-lua/popup.nvim"},
      {"nvim-lua/plenary.nvim"},
      {"nvim-telescope/telescope-ui-select.nvim"}
    }
  },
  {"mattn/emmet-vim"},
  {"norcalli/nvim-colorizer.lua"},
  {"lewis6991/gitsigns.nvim", dependencies = { "nvim-lua/plenary.nvim" }},
  {"kyazdani42/nvim-tree.lua", dependencies = { "kyazdani42/nvim-web-devicons" }},
  {"akinsho/bufferline.nvim"},
  "b3nj5m1n/kommentary",
  {"nvim-lualine/lualine.nvim", dependencies = { "kyazdani42/nvim-web-devicons", opt = true }},
  {"folke/todo-comments.nvim", dependencies = "nvim-lua/plenary.nvim"},
  {"nvim-treesitter/nvim-treesitter"},
  {"lukas-reineke/indent-blankline.nvim"},
  {"petertriho/nvim-scrollbar"},
  {"kevinhwang91/nvim-hlslens"},
  {"folke/which-key.nvim"},
  {"lervag/wiki.vim", init = require('plugins.config.wiki').init},
  {"jakewvincent/mkdnflow.nvim"},

  -- LSP & Completion
  {"williamboman/mason.nvim", dependencies = "williamboman/mason-lspconfig"},
  {"neovim/nvim-lspconfig"},
  "ray-x/lsp_signature.nvim",
  {"hrsh7th/nvim-cmp"},
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
  "pangloss/vim-javascript",
  "zah/nim.vim",
  {"rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap", "rcarriga/cmp-dap"}},
  "mfussenegger/nvim-jdtls",

  -- Theme
  {"marko-cerovac/material.nvim"},
}


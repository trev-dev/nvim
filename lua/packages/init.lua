local packer = require"packer"

packer.init{
  git = {
    clone_timeout = false,
  },
  max_jobs = 4,
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

packer.startup(function(use)
  -- Packer to manage itself
  use "wbthomason/packer.nvim"

  -- Tools
  use "godlygeek/tabular"
  use "jamessan/vim-gnupg"
  use "jiangmiao/auto-pairs"
  use "markonm/traces.vim" -- Shows substitutions in real-time
  use {
    "phaazon/hop.nvim",
    branch = "v1",
    config = function()
      require"packages.hop".setup()
    end
  }

  use {
    "akinsho/toggleterm.nvim",
    config = function()
      require"packages.toggleterm".setup()
    end
  }

  use {
    "mattn/emmet-vim",
    config = function()
      vim.g.user_emmet_leader_key = "<C-k>"
    end
  }

  use {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require"colorizer".setup()
    end
  }

  use {
    "lewis6991/gitsigns.nvim",
    requires = {
      "nvim-lua/plenary.nvim"
    },
    config = function()
      require"gitsigns".setup()
    end
  }
  use {
    "nvim-telescope/telescope.nvim",
    requires = {{"nvim-lua/popup.nvim"}, {"nvim-lua/plenary.nvim"}}
  }
  use {
    "nvim-telescope/telescope-project.nvim",
    config = function()
      require"packages.telescope".setup()
    end
  }
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icon
    },
    config = function()
      require"packages.nvim-tree".setup()
    end
  }

  use "tpope/vim-surround"
  use {
    "akinsho/bufferline.nvim",
    config = function()
      require"packages.bufferline".setup()
    end
  }

  use {
    "b3nj5m1n/kommentary",
    config = function()
      require"kommentary.config".use_extended_mappings()
    end
  }

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function()
      require"packages.lualine".setup()
    end
  }

  use {
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
  }

  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function()
      require"packages.treesitter".setup()
    end
  }
  use {
    "nvim-orgmode/orgmode",
    config = function()
      require("orgmode").setup {
        org_agenda_files = {"~/Org/*.org"},
        org_default_notes_file = "~/Org/notes.org"
      }
    end
  }

  use {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require"packages.indent-blankline".setup()
    end
  }
  use {
    "mickael-menu/zk-nvim",
    config = function()
      require"packages.zk".setup()
    end
  }

  use {
    "ellisonleao/glow.nvim",
    branch = "main",
    config = function()
      vim.g.glow_border = "rounded"
    end
  }

  use {
    "jakewvincent/mkdnflow.nvim",
    config = function()
      require'mkdnflow'.setup({
        filetypes = {md = true, markdown = true, org = true},
        mappings = {
          MkdnNewListItem = {'i', '<CR>'}
        }
      })
    end
  }

  use {
    "folke/zen-mode.nvim",
    config = function()
      require("zen-mode").setup()
    end
  }

  use {
    "petertriho/nvim-scrollbar",
    requires = "kevinhwang91/nvim-hlslens",
    config = function ()
      require("packages.nvim-scrollbar").setup()
    end
  }
  -- LSP & Completion
  use "ray-x/lsp_signature.nvim"
  use {
    "neovim/nvim-lspconfig",
    config = function()
      require"packages.lsp".setup()
    end
  }

  use {
    "williamboman/mason.nvim",
    config = function()
      require"mason".setup()
    end
  }

  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-cmdline"
  use {
    "hrsh7th/nvim-cmp",
    config = function()
      require"packages.nvim-cmp".setup()
    end
  }

  use "hrsh7th/cmp-vsnip"
  use "hrsh7th/vim-vsnip"
  use "hrsh7th/vim-vsnip-integ"
  use "rafamadriz/friendly-snippets"
  use {
    "prettier/vim-prettier",
    run = "yarn install"
  }

  use {
    "folke/which-key.nvim",
    config = function()
      require"packages.which-key".setup()
    end
  }

  use "romainl/vim-cool" -- Remove highlight after searching
  use "dhruvasagar/vim-table-mode"

  -- Syntax
  use "trev-dev/vim-shopify"
  use "ledger/vim-ledger"
  use {
    "kkoomen/vim-doge",
    run = ":call doge#install()"
  }

  use {
    "pangloss/vim-javascript",
    config = function()
      require"packages.vim-javascript".setup()
    end
  }

  use 'alaviss/nim.nvim'

  -- Themes
  use "kyazdani42/nvim-web-devicons"
  use "marko-cerovac/material.nvim"
end)

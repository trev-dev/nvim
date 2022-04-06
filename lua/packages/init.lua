local packer = require'packer'

packer.init{
  git = {
    clone_timeout = false,
  },
  max_jobs = 4
}

packer.startup(function(use)
  -- Packer to manage itself
  use 'wbthomason/packer.nvim'
  -- Tools
  use 'easymotion/vim-easymotion'
  use 'godlygeek/tabular'
  use 'jamessan/vim-gnupg'
  use 'jceb/vim-orgmode'
  use 'jiangmiao/auto-pairs'
  use 'markonm/traces.vim' -- Shows substitutions in real-time
  use {
    'akinsho/toggleterm.nvim',
    config = require'packages.toggleterm'.setup()
  }
  use {
    'mattn/emmet-vim',
    config = function()
      vim.g.user_emmet_leader_key = '<C-k>'
    end
  }
  use {
   'norcalli/nvim-colorizer.lua',
   config = require'colorizer'.setup()
  }
  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
    config = require'gitsigns'.setup()
  }
  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
  }
  use { 
    'nvim-telescope/telescope-project.nvim',
    config = require'packages.telescope'.setup()
  }
  use 'tpope/vim-surround'
  use {
    'akinsho/bufferline.nvim',
    config = require 'packages.bufferline'.setup()
  }
  use {
    'b3nj5m1n/kommentary',
    config = require'kommentary.config'.use_extended_mappings()
  }
  use {
    'NTBBloodbath/galaxyline.nvim',
    branch = 'main',
    config = require'packages.galaxyline'.setup()
  }
  use {
    'folke/todo-comments.nvim',
    requires = 'nvim-lua/plenary.nvim',
  }
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = require'packages.treesitter'.setup()
  }
  use {
    'nvim-neorg/neorg',
    requires = 'nvim-lua/plenary.nvim',
    config = require'packages.neorg'.setup()
  }
  use {
    'lukas-reineke/indent-blankline.nvim',
    config = require'packages.indent-blankline'.setup()
  }

  -- LSP & Completion
  use {
    'neovim/nvim-lspconfig',
    config = require'packages.lsp'.setup()
  }
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use {
    'hrsh7th/nvim-cmp',
    config = require'packages.nvim-cmp'.setup()
  }
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'
  use 'hrsh7th/vim-vsnip-integ'
  use 'ray-x/lsp_signature.nvim'
  use 'rafamadriz/friendly-snippets'
  use {
    'prettier/vim-prettier',
    run = 'yarn install'
  }
  use {
    'folke/which-key.nvim',
    config = require'which-key'.setup()
  }
  use 'romainl/vim-cool' -- Remove highlight after searching

  -- Syntax
  use 'trev-dev/vim-shopify'
  use 'ledger/vim-ledger'
  use {
    'kkoomen/vim-doge',
    run = ":call doge#install()"
  }
  use {
    'pangloss/vim-javascript',
    config = require'packages.vim-javascript'.setup()
  }

  -- Themes
  use 'kyazdani42/nvim-web-devicons'
  use 'dracula/vim'
  use 'morhetz/gruvbox'
  use 'jnurmine/Zenburn'
  use 'kristijanhusak/vim-hybrid-material'
  use 'gosukiwi/vim-atom-dark'
  use 'rakr/vim-one'
  use 'marko-cerovac/material.nvim'
end)

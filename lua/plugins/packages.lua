local packer = require'packer'

packer.init{
  git = {
    clone_timeout = 120
  }
}

packer.startup(function(use)
  -- Packer to manage itself
  use 'wbthomason/packer.nvim'
  -- Tools
  use 'dhruvasagar/vim-dotoo'
  use 'easymotion/vim-easymotion'
  use 'godlygeek/tabular'
  use 'jamessan/vim-gnupg'
  use 'jceb/vim-orgmode'
  use 'jiangmiao/auto-pairs'
  use 'markonm/traces.vim'
  use 'mattn/emmet-vim'
  use 'norcalli/nvim-colorizer.lua'
  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    }
  }
  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
  }
  use 'nvim-telescope/telescope-project.nvim'
  use 'tpope/vim-surround'
  use 'romgrk/barbar.nvim'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'
  use {
    'junegunn/gv.vim',
    requires = {
      'tpope/vim-fugitive'
    }
  }
  use 'b3nj5m1n/kommentary'
  use {
    'glepnir/galaxyline.nvim',
    branch = 'main'
  }
  use {
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
  }
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  -- LSP & Completion
  use 'hrsh7th/nvim-compe'
  use 'hrsh7th/vim-vsnip'
  use 'hrsh7th/vim-vsnip-integ'
  use 'neovim/nvim-lspconfig'
  use 'ray-x/lsp_signature.nvim'
  use 'rafamadriz/friendly-snippets'
  use {
    'prettier/vim-prettier',
    run = "yarn install"
  }
  -- Syntax
  -- use 'tpope/vim-liquid'
  use 'ledger/vim-ledger'
  -- Themes
  use 'kyazdani42/nvim-web-devicons'
  use 'dracula/vim'
  use 'morhetz/gruvbox'
  use 'jnurmine/Zenburn'
  use 'kristijanhusak/vim-hybrid-material'
  use 'gosukiwi/vim-atom-dark'
  use 'rakr/vim-one'
  use 'kaicataldo/material.vim'
end)

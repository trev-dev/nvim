local packer = require'packer'

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
  use 'wbthomason/packer.nvim'
  -- Tools
  -- use 'easymotion/vim-easymotion'
  use 'godlygeek/tabular'
  use 'jamessan/vim-gnupg'
  use 'jceb/vim-orgmode'
  use 'jiangmiao/auto-pairs'
  use 'markonm/traces.vim' -- Shows substitutions in real-time
  use {
     'phaazon/hop.nvim',
     branch = 'v1',
     config = function()
        require'packages.hop'.setup()
     end
  }
  use {
     'akinsho/toggleterm.nvim',
     config = function()
        require'packages.toggleterm'.setup()
     end
  }
  use {
    'mattn/emmet-vim',
    config = function()
       vim.g.user_emmet_leader_key = '<C-k>'
    end
  }
  use {
     'norcalli/nvim-colorizer.lua',
     config = function()
        require'colorizer'.setup()
     end
  }
  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
    config = function()
      require'gitsigns'.setup()
    end
  }
  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
  }
  use {
    'nvim-telescope/telescope-project.nvim',
    config = function()
      require'packages.telescope'.setup()
    end
  }
  use 'tpope/vim-surround'
  use {
    'akinsho/bufferline.nvim',
    config = function()
      require'packages.bufferline'.setup()
    end
  }
  use {
    'b3nj5m1n/kommentary',
    config = function()
       require'kommentary.config'.use_extended_mappings()
    end
  }
  use {
    'NTBBloodbath/galaxyline.nvim',
    branch = 'main',
    config = function()
      require'packages.galaxyline'.setup()
    end
  }
  use {
    'folke/todo-comments.nvim',
    requires = 'nvim-lua/plenary.nvim',
  }
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require'packages.treesitter'.setup()
    end
  }
  --[[ use {
    'nvim-neorg/neorg',
    requires = 'nvim-lua/plenary.nvim',
    config = function()
      require'packages.neorg'.setup()
    end
  } ]]
  use {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
       require'packages.indent-blankline'.setup()
    end
  }

  -- LSP & Completion
  use {
    'neovim/nvim-lspconfig',
    config = function()
      require'packages.lsp'.setup()
    end
  }
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use {
    'hrsh7th/nvim-cmp',
    config = function()
       require'packages.nvim-cmp'.setup()
    end
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
    config = function()
      require'packages.which-key'.setup()
    end
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
    config = function()
       require'packages.vim-javascript'.setup()
    end
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

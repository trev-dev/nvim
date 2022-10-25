# trevDev's Mirrored Neovim Configuration

*NOTE*:  This is a mirror of my upstream repository.  I suggest you check out [Sourcehut](https://sr.ht/~trevdev/nvim/).

Here be my Neovim configuration!

## Features

*  Package management with [Packer](https://github.com/wbthomason/packer.nvim)
*  Mostly JavaScript related LSP support with nvim-cmp completions
*  [Telescope](https://github.com/nvim-telescope/telescope.nvim)!
*  [Toggleterm](https://github.com/akinsho/toggleterm.nvim) with a [lazygit](https://github.com/jesseduffield/lazygit) [binding](2022-10-14_binding.md)
*  Markdown focused editing with [mkdnflow](https://github.com/jakewvincent/mkdnflow.nvim)
*  Support for Michael Menu's [Zettlekasten](https://github.com/mickael-menu/zk) cli app
*  Lots more.  Poke around :)

## Config Structure
```bash
.
├── init.lua # entry point
└── lua
    ├── autocommands.lua # Some ft specific stuff here
    ├── package
    │   └── many package config modules
    ├── packages.lua # packer helper lib
    ├── utils.lua
    ├── vim-bindings.lua
    └── vim-settings.lua
```

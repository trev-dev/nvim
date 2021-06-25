# trevDev's Neovim Configuration

Here lies my latest Neovim configuration with _native LSP support_ for Neovim 0.5.0+. It's set up with my workflow in mind but you may fork/tweak it if you like.

## Features

* Package management with [Packer](https://github.com/wbthomason/packer.nvim)
* Some basic web development LSP stuff, and some not so basic stuff (Vue, Svelte, Liquid, Tailwind CSS)
* [Neogit](TimUntersberger/neogit) - an up-and-coming Magit clone.
* [Telescope](https://github.com/nvim-telescope/telescope.nvim) with telescope-project for project management
* Other stuff.

## Config Structure

```bash
.config/nvim # Entrypoint
├── init.lua 
├── lua
│   ├── autocommands.lua
│   ├── plugins # Where Package configuration lives. Uses Packer.
│   │   ├── main.lua # Packer entrypoint
│   │   ├── packages.lua # Package imports
│   │   └── # Multiple application specific configurations imported by main.lua
│   ├── statusline.lua #WIP
│   ├── theme.lua
│   ├── vim-bindings.lua # General Bindings
│   └── vim-settings.lua # General Settings
└── plugin
    └── packer_compiled.vim # Ignored.
```

# trevDev's Neovim Configuration

Here be a Neovim configuration!  I am an Emacs exile who was searching for a faster, more ergonomic and focused IDE experience.  I still enjoy Lisp.  If that's your bag, you may enjoy this config as it is written in Fennel and all of it's clojure-esque glory.

A big thanks for [Oliver Caldwell](https://github.com/Olical) for providing the means for people like myself to Lisp like ever before in Neovim.  Check out their [magic-kit](https://github.com/Olical/magic-kit) for a less opinionated base configuration.

## Features

*  Written in [Fennel](https://fennel-lang.org/) with the help of [aniseed](https://github.com/Olical/aniseed).  Use the [conjure](https://github.com/Olical/conjure) package to evaluate the and update this configuration on-the-fly!
*  Package management with [Packer](https://github.com/wbthomason/packer.nvim)
*  Mostly JavaScript related LSP support with nvim-cmp completions
*  [Telescope](https://github.com/nvim-telescope/telescope.nvim)!
*  [Toggleterm](https://github.com/akinsho/toggleterm.nvim) with a [lazygit](https://github.com/jesseduffield/lazygit) [binding](2022-10-14_binding.md)
*  Material dark theme with icons and rounded borders
*  Markdown focused editing with [mkdnflow](https://github.com/jakewvincent/mkdnflow.nvim)
*  Support for Michael Menu's [Zettlekasten](https://github.com/mickael-menu/zk) cli app
*  Lots more.  Poke around :)

## Config Structure
```bash
├── fnl
│   └── tdev
│       ├── init.fnl # Entrypoint
│       ├── package
│       │   └── # Many package configuration modules
│       ├── packages.fnl # Package util module
│       └── utils.fnl # Misc utilities
├── init.lua # Bootstrapping
└── README.md
```

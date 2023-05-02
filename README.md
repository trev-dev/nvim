# A Neovim Configuration

Written by an Emacs refugee who wanted more out of his IDE.  Intended to be used
with Arch Linux.

## Features

* Written in [Fennel](https://fennel-lang.org)
* [Neorg](https://github.com/nvim-neorg) note taking
* Productive support for Java and JavaScript
* Lots more. Poke around :)

## Config Structure
```bash
.
├── fnl
│   └── config
│       ├── filetype
│       │   └── # Filetype specific modules
│       ├── init.fnl # Config root
│       ├── plugin
│       │   └── # Plugin config modules
│       ├── plugin.fnl
│       └── util.fnl
└── init.lua
```

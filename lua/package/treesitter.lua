local ok = pcall(require, "nvim-treesitter")
if not ok then return end

local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()
local M = {}

require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "bash",
    "css",
    "html",
    "javascript",
    "json",
    "lua",
    "markdown",
    "org",
    "nix",
    "php",
    "python",
    "scheme",
    "svelte",
    "toml",
    "typescript",
    "vim",
    "yaml",
  },
  sync_install = false,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = {"org"},
    disable = {"help"}
  }
})

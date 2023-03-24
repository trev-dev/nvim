local utils = require('utils')

utils.safe_require('settings')
utils.safe_require('autocommands')
utils.safe_require('bindings')

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")

function toConfigModule(path)
  return "plugins.config." .. vim.fn.matchstr(path, "\\v[a-z-]+\\ze\\.lua")
end

function collectConfigs()
  local config_path = os.getenv("HOME") .. "/.config/nvim/lua/plugins/config/*.lua"
  local configs = vim.split(vim.fn.glob(config_path), "\n")
  return utils.map(configs, toConfigModule)
end

for _, mod in pairs(collectConfigs()) do utils.safe_require(mod) end

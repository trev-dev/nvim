local ok = pcall(require, "nvim-treesitter")
if not ok then return end

local disable = function(lang, buf)
  if lang == "help" then return true end
  local max_filesize = 100 * 1024 -- 200 KB
  local fs, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
  if fs and stats and stats.size > max_filesize then
    return true
  end
end

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
    disable = disable
  }
})
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
    "java",
    "javascript",
    "json",
    "markdown",
    "markdown_inline",
    "lua",
    "nix",
    "php",
    "python",
    "scheme",
    "svelte",
    "toml",
    "typescript",
    "vim",
    "vue",
    "yaml",
  },
  sync_install = false,
  indent = { enable = true, disable = { 'python' } },
  highlight = {
    enable = true,
    disable = disable
  }
})

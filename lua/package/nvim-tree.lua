local ok, nvt = pcall(require, "nvim-tree")
if not ok then return end

nvt.setup {
  view = {
    width = 50
  },
  renderer = {
    group_empty = true,
    highlight_git = true
  },
  update_focused_file = {
    enable = true
  }
}

vim.keymap.set("n", "<leader>n", ":NvimTreeToggle<cr>")


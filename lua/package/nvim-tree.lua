local ok, nvt = pcall(require, "nvim-tree")
if not ok then return end

nvt.setup {
  view = {
    width = 50
  }
}

vim.keymap.set("n", "<C-k>b", ":NvimTreeToggle<cr>")


local ok, nvt = pcall(require, "nvim-tree")
if not ok then return end

nvt.setup()

vim.keymap.set("n", "<C-k>b", ":NvimTreeToggle<cr>")


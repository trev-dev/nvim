local ok, tdc = pcall(require, "todo-comments")
if not ok then return end

tdc.setup({
  keywords = {
    TODO = { icon = " ", color = "info" },
    DONE = { icon = " ", color = "comment" }
  },
  colors = {
    comment = { "Comment" }
  }
})

vim.keymap.set("n", "<leader>ft", ":TodoTelescope<cr>", { desc = "todos" })

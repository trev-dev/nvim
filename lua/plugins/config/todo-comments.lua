require("todo-comments").setup {
  keywords = {
    TODO = { icon = " ", color = "info" },
    DONE = { icon = " ", color = "comment" }
  },
  colors = {
    comment = { "Comment" }
  }
}

vim.keymap.set("n", "<leader>ft", ":TodoTelescope<cr>", { desc = "todos" })

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

local bind = require("utils").bind

bind("<leader>ft", "TodoTelescope")

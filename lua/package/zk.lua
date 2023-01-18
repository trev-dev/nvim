local ok, zk = pcall(require, "zk")
if not ok then return end

local bind = require("utils").bind
bind("<leader>zf", "ZkNotes")
bind("<leader>zf", "'<,'>ZkMatch")
bind("<leader>zn", "ZkNew { title = vim.fn.input('Title: ') }")
bind("<leader>zt", "ZkTags")

zk.setup({ picker = "telescope" })

local ok, nvt = pcall(require, "nvim-tree")
if not ok then return end

nvt.setup()

local bind = require("utils").bind
bind('<C-k>b', 'NvimTreeToggle')


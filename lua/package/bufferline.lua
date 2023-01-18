local ok, buffl = pcall(require, "bufferline")
if not ok then return end

local bind = require("utils").bind

bind("gb", 'BufferLinePick')

buffl.setup()

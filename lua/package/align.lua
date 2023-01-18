local ok, a = pcall(require, "align")
if not ok then return end

local bind = require("utils").bind

local op_to_string = function()
  a.operator(a.align_to_string, {
    is_pattern = false,
    reverse = true,
    preview = true
  })
end

local vis_to_string = function()
  a.align_to_string(true, true, true)
end

bind("aw", vis_to_string, { mode = "x" })
bind("gaw", op_to_string)

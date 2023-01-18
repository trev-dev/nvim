local ok, hop = pcall(require, "hop")
if not ok then return end

local bind = require("utils").bind

bind("<leader>s", "HopChar1")

hop.setup({ keys = "etovxqpdygfblzhckisuran", case_insensitive = false })

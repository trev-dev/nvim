local material = require'material'
local g = vim.g
local cmd = vim.cmd

material.setup{}

g.material_style = 'darker'
cmd[[colorscheme material]]
-- cmd[[au VimEnter * highlight ColorColumn guibg=#171717]]

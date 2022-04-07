local o = vim.o
local wo = vim.wo
local bo = vim.bo

-- Global
o.termguicolors = true
o.listchars = 'trail:~'
o.list = true
o.expandtab = true
o.shiftwidth = 2
o.softtabstop = 2
o.tabstop = 2
o.lbr = true
o.redrawtime = 10000
o.clipboard = 'unnamedplus'
o.mouse = 'a'

-- Window
wo.breakindent = true
wo.colorcolumn = '80'
wo.linebreak = true
wo.number = true
wo.relativenumber = true

-- Buffer
bo.smartindent = true


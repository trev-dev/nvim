local o = vim.o
local wo = vim.wo
local bo = vim.bo
local g = vim.g

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
o.guifont = "Source Code Pro:h11"

-- Window
wo.breakindent = true
wo.colorcolumn = '80'
wo.linebreak = true
wo.number = true
wo.relativenumber = true

-- HTML
g.html_indent_script1 = 'zero'
g.html_indent_style1 = 'zero'

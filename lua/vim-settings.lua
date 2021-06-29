local o = vim.o
local wo = vim.wo
local bo = vim.bo

-- Global
o.termguicolors = true
o.listchars='eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣'
o.expandtab = true
o.shiftwidth = 2
o.softtabstop = 2
o.tabstop = 2
o.lbr = true

-- Window
wo.breakindent = true
wo.colorcolumn = '80'
wo.linebreak = true
wo.number = true
wo.relativenumber = true


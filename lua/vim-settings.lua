local o = vim.o
local wo = vim.wo
local bo = vim.bo

-- Global
o.listchars='eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣'
o.termguicolors = true

-- Window
wo.breakindent = true
wo.colorcolumn = '80'
wo.linebreak = true
wo.number = true
wo.relativenumber = true

-- Buffers
bo.expandtab = true
bo.shiftwidth = 2
bo.softtabstop = 2
bo.tabstop = 2

local bind = require("utils").bind

local toggle_whitespace = function()
  local listchars = vim.o.listchars
  local all_chars = "eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣"
  local trailing_chars = "tab:>·,trail:~"

  if (listchars == all_chars) then
    vim.opt_local.listchars = trailing_chars
  else
    vim.opt_local.listchars = all_chars
  end
end

vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Buffers
bind("<leader>l", "ls")
bind("<leader>a", "blast")
bind("<leader>]", "bn!")
bind("<leader>[", "bp!")
bind("<leader>bd", "bd")

-- Toggle Whitespace Chars
bind("<leader>ws", toggle_whitespace)

-- Toggle Word Wrap
bind("<leader>r", "set wrap")

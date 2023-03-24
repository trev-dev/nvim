local bind = vim.keymap.set

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
bind("n", "<leader>l", "ls")
bind("n", "<leader>a", ":blast<cr>")
bind("n", "<leader>]", ":bn!<cr>")
bind("n", "<leader>[", ":bp!<cr>")

-- Toggle Whitespace Chars
bind("n", "<leader>ws", toggle_whitespace, { desc = "Toggle white space markers" })

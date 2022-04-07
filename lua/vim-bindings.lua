local map = vim.api.nvim_set_keymap

local defaults = { noremap = true }

local all_chars = 'eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣'
local trailing_chars = 'trail:~'

_SHOW_ALL_WHITESPACE = false

function _TOGGLE_WHITESPACE()
  if (_SHOW_ALL_WHITESPACE)
  then
    vim.o.listchars = trailing_chars
    _SHOW_ALL_WHITESPACE = false
  else
    vim.o.listchars = all_chars
    _SHOW_ALL_WHITESPACE = true
  end
end

-- Buffers
map('n', '<leader>l', ':ls<CR>', defaults)
map('n', '<leader>a', ':blast<CR>', defaults)
map('n', '<leader>]', ':bn!<CR>', defaults)
map('n', '<leader>[', ':bp!<CR>', defaults)
map('n', '<leader>bd', ':bd<CR>', defaults)

-- Toggle Whitespace Chars
map('n', '<leader>w', ':lua _TOGGLE_WHITESPACE()<CR>', defaults)

-- Toggle Word Wrap
map('n', '<leader>r', '<cmd>set wrap!<CR>', defaults)

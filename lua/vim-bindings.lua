local map = vim.api.nvim_set_keymap

local defaults = { noremap = true }

-- Buffers
map('n', '<leader>l', ':ls<CR>', defaults)
map('n', '<leader>a', ':blast<CR>', defaults)
map('n', '<leader>]', ':bn!<CR>', defaults)
map('n', '<leader>[', ':bp!<CR>', defaults)
map('n', '<leader>bd', ':bd<CR>', defaults)

-- Toggle Whitespace Chars
map('n', '<leader>w', ':set list!<CR>', defaults)

-- Toggle Word Wrap
map('n', '<leader>r', '<cmd>set wrap!<CR>', defaults)

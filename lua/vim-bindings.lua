local map = vim.api.nvim_set_keymap

local defaults = { noremap = true }
-- Reload Config
map('n', '<leader>rc', ':source $MYVIMRC<CR>', defaults)

-- Buffers
map('n', '<leader>l', ':ls<CR>', defaults)
map('n', '<leader>l', ':ls<CR>', defaults)
map('n', '<leader>]', ':bn!<CR>', defaults)
map('n', '<leader>[', ':bp!<CR>', defaults)
map('n', '<leader>bd', ':bd<CR>', defaults)

-- Toggle Whitespace Chars
map('n', '<leader>s', ':set list!<CR>', defaults)

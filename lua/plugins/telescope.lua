local map = vim.api.nvim_set_keymap
local defaults = { noremap = true }

-- Bindings
map('n', '<leader>ff', '<cmd>Telescope find_files<CR>', defaults)
map('n', '<leader>fr', '<cmd>Telescope live_grep<CR>', defaults)
map('n', '<leader>fg', '<cmd>Telescope git_files<CR>', defaults)
map('n', '<leader>fb', '<cmd>Telescope buffers<CR>', defaults)
map('n', '<leader>fh', '<cmd>Telescope help_tags<CR>', defaults)

local map = vim.api.nvim_set_keymap
require'neogit'.setup{}

map('n', '<leader>m', '<cmd>Neogit<CR>', { noremap = true })

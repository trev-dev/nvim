vim.g.db_ui_use_nerd_fonts = 1

local bind = vim.keymap.set

bind('n', '<leader>gd', ':DBUI<CR>', { desc = 'dadbod ui' })
bind('v', '<leader>db', ':DB<CR>', { desc = 'dadbod execute' })

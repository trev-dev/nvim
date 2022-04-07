local hop = require'hop'
local map = vim.api.nvim_set_keymap

map('n', '<leader>s', ':HopChar1<CR>', { noremap = true, silent = true })

return {
  setup = function()
    hop.setup{
      keys = 'etovxqpdygfblzhckisuran'
    }
  end
}

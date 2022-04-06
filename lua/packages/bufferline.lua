local bufferline = require'bufferline'
local map = vim.api.nvim_set_keymap

map('n', 'gb', ':BufferLinePick<CR>', {
  noremap = true,
  silent = true
})

return {
  setup = bufferline.setup
}

local map = vim.api.nvim_set_keymap
local zk = require'zk'

local config = {
  picker = 'telescope'
}
local opts = { noremap=true, silent=false }

map("n", "<leader>zf", ":ZkNotes<CR>", opts)
map("v", "<leader>zf", "'<,'>ZkMatch<CR>", opts)
map("n", "<leader>zn", ":ZkNew { title = vim.fn.input('Title: ') }<CR>", opts)
map("n", "<leader>zt", ":ZkTags<CR>", opts)

return {
  setup = function()
    zk.setup(config)
  end
}

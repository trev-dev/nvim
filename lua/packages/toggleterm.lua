local toggleterm = require'toggleterm'
local map = vim.api.nvim_set_keymap

return {
  setup = function() 
    toggleterm.setup({
      size = 20,
      open_mapping = [[<c-\>]],
      hide_numbers = true,
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      persist_size = true,
      direction = "float",
      close_on_exit = true,
      shell = vim.o.shell,
      float_opts = {
        border = "curved",
        winblend = 0,
        highlights = {
          border = "Normal",
          background = "Normal",
        },
      },
    })
    local Terminal = require("toggleterm.terminal").Terminal
    local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })
    function _LAZYGIT_TOGGLE()
      lazygit:toggle()
    end
    map('n', 'gs', ':lua _LAZYGIT_TOGGLE()<CR>', {
      noremap = true,
      silent = true
    })
  end
}

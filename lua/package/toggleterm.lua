local ok, toggleterm = pcall(require, "toggleterm")
if not ok then return end

toggleterm.setup({
  size = 20,
  open_mapping = "<c-;>",
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

local lazygit = Terminal:new({
  cmd = "lazygit", hidden = true
})
local toggle_lazygit = function()
  lazygit.dir = vim.fn.getcwd()
  lazygit:toggle()
end

local taskwarrior_tui = Terminal:new(
  { cmd = "taskwarrior-tui", hidden = true }
)

local toggle_tui = function() taskwarrior_tui:toggle() end

local bind = require("utils").bind
bind("<leader>gg", toggle_lazygit)
bind("<leader>gt", toggle_tui)
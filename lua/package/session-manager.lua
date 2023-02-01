local ok, sm = pcall(require, "session_manager")
if not ok then return end

sm.setup({
  autoload_mode = require("session_manager.config").AutoloadMode.CurrentDir
})

local bind = vim.keymap.set
bind("n", "<leader>pp", ":SessionManager load_session<cr>")
bind("n", "<leader>pl", ":SessionManager load_last_session<cr>")
bind("n", "<leader>ps", ":SessionManager save_current_session<cr>")
bind("n", "<leader>pD", ":SessionManager delete_session<cr>")

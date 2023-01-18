local ok, sm = pcall(require, "session_manager")
if not ok then return end

sm.setup({
  autoload_mode = require("session_manager.config").AutoloadMode.CurrentDir
})

local bind = require("utils").bind
bind("<leader>pp", "SessionManager load_session")
bind("<leader>pl", "SessionManager load_last_session")
bind("<leader>ps", "SessionManager save_current_session")
bind("<leader>pD", "SessionManager delete_session")

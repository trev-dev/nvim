local ok, zk = pcall(require, "zk")
if not ok then return end

local wkp, wk = pcall(require, "which-key")
if wkp then
  wk.register {z = {name = "ZK Notes"}, prefix = "<leader>"}
end

local bind = vim.keymap.set
bind("n", "<leader>zf", ":ZkNotes<cr>", { desc = "find note" })
bind("v", "<leader>zf", ":'<,'>ZkMatch<cr>", { desc = "find note" })
bind("n", "<leader>zn", ":ZkNew { title = vim.fn.input('Title: ') }<cr>", { desc = "new note" })
bind("n", "<leader>zt", ":ZkTags<cr>", { desc = "note tags" })

zk.setup({ picker = "telescope" })

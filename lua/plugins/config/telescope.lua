local telescope = require("telescope")

telescope.setup {
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown({})
    }
  }
}

telescope.load_extension("ui-select")

local wkp, wk = pcall(require, "which-key")
if wkp then
  wk.register {f = {name = "Find"}, prefix = "<leader>"}
end

local bind = vim.keymap.set
bind("n", "<leader>ff", ":Telescope find_files<cr>", { desc = "files" })
bind("n", "<leader>fr", ":Telescope live_grep<cr>", { desc = "grep" })
bind("n", "<leader>fg", ":Telescope git_files<cr>", { desc = "git files" })
bind("n", "<leader>fb", ":Telescope buffers<cr>", { desc = "buffers" })
bind("n", "<leader>fh", ":Telescope help_tags<cr>", { desc = "help tags" })

local ok, telescope = pcall(require, "telescope")
if not ok then return end

telescope.setup({
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown({})
    }
  }
})

telescope.load_extension("ui-select")

local bind = require("utils").bind

bind('<leader>ff', 'Telescope find_files')
bind('<leader>fr', 'Telescope live_grep')
bind('<leader>fg', 'Telescope git_files')
bind('<leader>fb', 'Telescope buffers')
bind('<leader>fh', 'Telescope help_tags')

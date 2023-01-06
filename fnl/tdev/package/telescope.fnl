(module tdev.package.telescope
  {autoload {utils tdev.utils}})

(let [(ok? telescope) (pcall #(require :telescope))]
  (when ok?
    (telescope.load_extension :projects)
    (utils.map :<leader>ff "Telescope find_files")
    (utils.map :<leader>fr "Telescope live_grep")
    (utils.map :<leader>fg "Telescope git_files")
    (utils.map :<leader>fb "Telescope buffers")
    (utils.map :<leader>fh "Telescope help_tags")
    (utils.map :<leader>fp "Telescope projects")))

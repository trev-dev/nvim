local M = {
  setup = function()
    require('neorg').setup {
      load = {
        ["core.defaults"] = {},
        ["core.norg.dirman"] = {
          config = {
            workspaces = {
              root = "~/Neorg",
            }
          }
        }
      }
    }
  end
}

return M

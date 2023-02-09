local ok, neorg = pcall(require, 'neorg')
if not ok then return end

neorg.setup {
  load = {
    ["core.defaults"] = {},
    ["core.export"] = {},
    ["core.norg.concealer"] = {},
    ["core.norg.dirman"] = {
      config = {
        workspaces = {
          work = "~/Norg/work",
          home = "~/Norg/home"
        }
      }
    }
  }
}

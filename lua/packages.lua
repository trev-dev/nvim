local packer = require("packer")
local utils = require("utils")

packer.init({ git = { clone_timeout = false }, max_jobs = 4 })

local safe_require_pkg_config = function (m)
  return utils.safe_require("package." .. m)
end

local pop_module_key = function(tbl)
  local module = tbl.mod
  tbl.mod = nil
  return module
end

local use_package_list = function(pkgs)
  require("packer").startup(function(use)
    for _, pkg in ipairs(pkgs) do
      local m

      if type(pkg) == "table" then
        m = pop_module_key(pkg)
        if utils.tlen(pkg) == 1 then
          pkg = pkg[1]
        end
      end

      use(pkg)

      if m ~= nil and not safe_require_pkg_config(m) then
        print("Failed to load config module for " .. pkg)
      end
    end
  end)
end

return {
  use = use_package_list
}


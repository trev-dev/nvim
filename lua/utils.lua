local exec = vim.api.nvim_command
local fmt = string.format
local fn = vim.fn

local merge_tables = function (tbl_a, tbl_b)
  local new_table = tbl_a
  for k,v in pairs(tbl_b) do
    new_table[k] = v
  end
  return new_table
end

local ensure_installed = function(user, repo)
  local pack_path = fn.stdpath("data") .. "/site/pack"
  local install_path = fmt("%s/packer/start/%s", pack_path, repo, repo)
  if fn.empty(fn.glob(install_path)) > 0 then
    exec(
      fmt("!git clone https://github.com/%s/%s %s", user, repo, install_path)
    )
    exec(fmt("packadd %s", repo))
  end
end

local safe_require = function (m)
  ok, cfg = pcall(require, m)
  if not ok then
    print("Failed to load lua module: " .. m)
    print(cfg)
  end
  return ok
end

local create_keybind = function(lhs, cmd, bopts, mopts)
  mopts = mopts or {}
  bopts = bopts or {}

  mopts = merge_tables({ noremap = true, silent = true }, mopts)
  bopts = merge_tables({ mode = "n" }, bopts)
  local rhs = ""

  if (type(cmd) == "string" and bopts.plain) then
    rhs = cmd
  elseif (type(cmd) == "string") then
    rhs = ":" .. cmd .. "<CR>"
  elseif(type(cmd) == "function") then
    mopts.callback = cmd
  end

  vim.keymap.set(bopts.mode, lhs, rhs, mopts)
end

local count_table_length = function(t)
  local c = 0
  for _ in pairs(t) do c = c + 1 end
  return c
end

local table_value = function(tbl, i)
  return tbl[i]
end

return {
  ensure = ensure_installed,
  safe_require = safe_require,
  bind = create_keybind,
  merge = merge_tables,
  tlen = count_table_length,
  tval = table_value,
}

local ok, scrollbar = pcall(require, "scrollbar")
if not ok then return end

local conf = {
  handle = { color = "#323232" },
  handlers = { diagnostic = true, search = true }
}

local useTheme, colors = pcall(require, "material.colors")
if useTheme then
  conf.marks = {
    Search = { color = colors.editor.fg }
  }
end

scrollbar.setup(conf)

if pcall(require, "hlslens") == true then
  require("scrollbar.handlers.search").setup()
end

local ok, scrollbar = pcall(require, "scrollbar")
if not ok then return end

scrollbar.setup({ handlers = { diagnostic = true, search = true } })

if pcall(require, "hlslens") == true then
  require("scrollbar.handlers.search").setup()
end

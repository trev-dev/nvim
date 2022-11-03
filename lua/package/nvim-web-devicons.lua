local ok, nvwd = pcall(require, "nvim-web-devicons")
if not ok then return end

nvwd.setup({
  override = {
    nim = {
      icon = "",
      color = "#F3D400",
      cterm_color = "220",
      name = "Nim"
    }
  }
})

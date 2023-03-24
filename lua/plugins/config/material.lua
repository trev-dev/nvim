require("material").setup({
  styles = {
    comments = { italic = true }
  },
  plugins = {
    -- Available plugins:
    -- "dap",
    -- "dashboard",
    "gitsigns",
    "hop",
    "indent-blankline",
    -- "lspsaga",
    -- "mini",
    -- "neogit",
    "nvim-cmp",
    -- "nvim-navic",
    "nvim-tree",
    -- "sneak",
    "telescope",
    -- "trouble",
    "which-key",
  },
  disable = { background = true },
  custom_colors = function(colors)
    colors.syntax.comments = "#F07178"
  end
})

vim.g.material_style = 'darker'
vim.cmd[[colorscheme material]]

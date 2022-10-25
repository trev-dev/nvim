local ok, material = pcall(require, "material")
if not ok then return end

material.setup({
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
  disable = { background = true }
})

vim.g.material_style = 'darker'
vim.cmd[[colorscheme material]]

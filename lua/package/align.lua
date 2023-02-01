local ok, a = pcall(require, "align")
if not ok then return end

local op_to_string = function()
  a.operator(a.align_to_string, {
    is_pattern = false,
    reverse = true,
    preview = true
  })
end

local vis_to_string = function()
  a.align_to_string(true, true, true)
end

vim.keymap.set("x", "aw", vis_to_string)
vim.keymap.set({ "v", "n" }, "gaw", op_to_string, { desc = "Align around word" })

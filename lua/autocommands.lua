local create_augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local bo = vim.bo
local wo = vim.wo

local relative_toggle = create_augroup("RelativeNumToggle", { clear = true })
autocmd({"BufEnter", "FocusGained", "InsertLeave"}, {
  group = relative_toggle,
  pattern = "*",
  callback = function()
    if (wo.number) then
      wo.relativenumber = true
    end
  end
})

autocmd({"BufLeave", "FocusLost", "InsertEnter"}, {
  group = relative_toggle,
  pattern = "*",
  callback = function()
    wo.relativenumber = false
  end
})

-- Load/save views on enter/leave. Preserves folding.
autocmd({"BufWinLeave"}, {
  pattern = "*",
  command = "silent! mkview"
})

autocmd({"BufWinEnter"}, {
  pattern = "*",
  command = "silent! loadview"
})

-- File specific indentation
local python_context = create_augroup("PythonIndentContext", { clear = true })
local adjust_python_indent = function()
  bo.tabstop = 4
  bo.shiftwidth = 4
  bo.softtabstop = 4
  bo.expandtab = true
end
autocmd({"FileType"}, {
  group = python_context,
  callback = adjust_python_indent,
  pattern = "python"
})

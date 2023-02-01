local autogrp = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local bo = vim.bo
local wo = vim.wo
local setlocal = vim.opt_local
local bind = vim.keymap.set

local relative_toggle = autogrp("RelativeNumToggle", { clear = true })
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

autocmd("BufWrite", {
  pattern = { "/home/trev/.config/nvim/*" },
  callback = function ()
    require("packer").compile()
    print("Packer Compiled")
  end
})

-- File specific indentation
-- TODO: Set up individual files for ft contexts

local python_context = autogrp("PythonIndentContext", { clear = true })
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

autocmd({"BufEnter"}, {
  pattern = { "*.md", "*.markdown", "*.org" },
  callback = function()
    setlocal.conceallevel = 2
    setlocal.concealcursor = 'nc'
  end
})

local ok, tt = pcall(require, "toggleterm.terminal")
if ok then
  local buff = vim.api.nvim_buf_get_name

  local make_nim_terminal = function(opt)
    return tt.Terminal:new({
      cmd = "nim " .. opt .. " " .. buff(0),
      hidden = true,
      close_on_exit = false
    })
  end

  local nim_run_buffer = function() make_nim_terminal("r"):toggle() end
  local nim_compile_buffer = function() make_nim_terminal("c"):toggle() end
  local nim_format_buffer = function()
    vim.cmd("!nimpretty " .. buff(0))
  end

  local setup_nim_context = function()
    bind("n", "<localleader>cr", nim_run_buffer, { desc = "Nim run" })
    bind("n", "<localleader>cb", nim_compile_buffer, { desc = "Nim compile buffer" })
    bind("n", "<localleader>bf", nim_format_buffer, { desc = "Nim format buffer" })
  end

  autocmd({"FileType"}, {
    group = autogrp("NimContext", { clear = true }),
    pattern = "nim",
    callback = setup_nim_context
  })
end

local highlight_yanked = function()
  vim.highlight.on_yank({ higroup = "Visual", timeout = 350 })
end

autocmd({"TextYankPost"}, {
  group = autogrp("HighlightYank", {}),
  pattern = "*",
  callback = highlight_yanked
})


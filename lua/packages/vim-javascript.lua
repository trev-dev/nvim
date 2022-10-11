local g = vim.g
local cmd = vim.cmd
local setlocal = vim.opt_local
local autogrp = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd


return {
  setup = function()
    local javascript_folding = autogrp("javascript_folding", {clear = true});
    autocmd({"FileType"}, {
      group = javascript_folding,
      pattern = "javascript",
      callback = function()
        g.javascript_plugin_jsdoc = 1
        g.javascript_plugin_ngdoc = 1
        setlocal.foldmethod = "syntax"
      end
    })
  end
}

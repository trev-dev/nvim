local g = vim.g
local cmd = vim.cmd

g.javascript_plugin_jsdoc = 1
g.javascript_plugin_ngdoc = 1

return {
  setup = function()
    cmd[[
      augroup javascript_folding
        au!
        au FileType javascript setlocal foldmethod=syntax
      augroup END
    ]]
  end
}

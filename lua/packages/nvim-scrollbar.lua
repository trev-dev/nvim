local scrollbar = require("scrollbar")
local map = vim.keymap
local kopts = {noremap = true, silent = true}

local map = vim.keymap
return {
  setup = function ()
    map.set('n', 'n', [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]], kopts)
    map.set('n', 'N', [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]], kopts)
    map.set('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
    map.set('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
    map.set('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
    map.set('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)
    scrollbar.setup({
      handlers = {
        diagnostic = true,
        search = true
      }
    })
  end
}

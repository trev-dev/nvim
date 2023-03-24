require("hlslens").setup()

local bind = vim.keymap.set

bind("n", 'n',
  "<cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<cr>")
bind("n", 'N',
  "<cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<cr>")
bind("n", '*', "*<Cmd>lua require('hlslens').start()<CR>")
bind("n", '#', "#<Cmd>lua require('hlslens').start()<CR>")
bind("n", 'g*', "g*<Cmd>lua require('hlslens').start()<CR>")
bind("n", 'g#', "g#<Cmd>lua require('hlslens').start()<CR>")

bind("n", "<Leader>l", ":noh<cr>")

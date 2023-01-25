local ok, hlsl = pcall(require, "hlslens")
if not ok then return end

hlsl.setup()

local bind = require("utils").bind

bind('n',
     "execute('normal! ' . v:count1 . 'n')<CR>" ..
     "<Cmd>lua require('hlslens').start()")
bind('N',
     "execute('normal! ' . v:count1 . 'N')<CR>" ..
     "<Cmd>lua require('hlslens').start()")

bind('*', "*<Cmd>lua require('hlslens').start()<CR>", { plain = true })
bind('#', "#<Cmd>lua require('hlslens').start()<CR>", { plain = true })
bind('g*', "g*<Cmd>lua require('hlslens').start()<CR>", { plain = true })
bind('g#', "g#<Cmd>lua require('hlslens').start()<CR>", { plain = true })

bind("<Leader>l", "noh")

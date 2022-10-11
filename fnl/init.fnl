(module init
  {autoload {nvim aniseed.nvim
             au autocommands}})

;; General Neovim Settings

(let [o nvim.o
      wo nvim.wo
      bo nvim.bo
      g  nvim.g]

  ;; Global
  (set o.mouse "a")
  (set o.termguicolors true)
  (set o.listchars "trail:~")
  (set o.list true)
  (set o.expandtab true)
  (set o.shiftwidth 2)
  (set o.softtabstop 2)
  (set o.tabstop 2)
  (set o.lbr true)
  (set o.redrawtime 10000)
  (set o.clipboard "unnamedplus")
  (set o.guifont "Source Code Pro:h11")

  ;; Window
  (set wo.breakindent true)
  (set wo.colorcolumn "80")
  (set wo.linebreak true)
  (set wo.number true)
  (set wo.relativenumber true)

  (set g.html_indent_script1 "zero")
  (set g.html_indent_style1 "zero"))

(au.setup)

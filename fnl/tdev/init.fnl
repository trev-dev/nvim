(module tdev.init
  {autoload {nvim aniseed.nvim
             packages tdev.packages}})

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

;; General Keybinds

(set nvim.g.mapleader " ")
(var all-chars "eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣")
(var trailing-chars "trail:~")

(global _TOGGLE_WHITESPACE
  (fn []
    (let [listchars vim.o.listchars]
      (set vim.o.listchars (if (= listchars all-chars)
                             trailing-chars
                             all-chars)))))

(let [map vim.api.nvim_set_keymap
      opts {:noremap true}]
  (map "n" "<leader>l" ":ls<CR>" opts)
  (map "n" "<leader>a" ":blast<CR>" opts)
  (map "n" "<leader>]" ":bn!<CR>" opts)
  (map "n" "<leader>[" ":bp!<CR>" opts)
  (map "n" "<leader>bd" ":bd<CR>" opts)
  (map "n" "<leader>w" ":lua _TOGGLE_WHITESPACE()<CR>" opts)
  (map "n" "<leader>r" "<cmd>set wrap!<CR>" opts))

;; Autocommands

(let [create_augroup vim.api.nvim_create_augroup
      autocmd vim.api.nvim_create_autocmd
      wo nvim.wo
      bo nvim.bo
      lo vim.opt_local]

  (let [relative_toggle (create_augroup "RelativeNumToggle" {:clear true})]
    (autocmd ["BufEnter" "FocusGained" "InsertLeave"]
             {:group relative_toggle
              :pattern "*"
              :callback (lambda []
                          (when wo.number
                            (set wo.relativenumber true)))})
    (autocmd ["BufLeave" "FocusLost" "InsertEnter"]
             {:group relative_toggle
              :pattern "*"
              :callback (lambda [] (set wo.relativenumber false))}))

  ;; Preserve manual folding
  (autocmd ["BufWinLeave"]
           {:pattern "*" :command "silent! mkview"})
  (autocmd ["BufWinLeave"]
           {:pattern "*" :command "silent! loadview"})

  ;; Filetype specific indentation
  (autocmd ["FileType"]
           {:group (create_augroup "PythonIndentContext" {:clear true})
            :pattern "python"
            :callback (lambda []
                        (set bo.tabstop 4)
                        (set bo.shiftwidth 4)
                        (set bo.softtabstop 4)
                        (set bo.expandtab true))})

  ;; Fancy conceals for document files
  (autocmd ["BufEnter"]
           {:pattern ["*.md" "*.markdown" "*.org"]
            :callback (lambda []
                        (set lo.conceallevel 2)
                        (set lo.concealcursor "nc"))})
  ;; TODO Maybe add packer autocommand
  )

;; Package configurations

(packages.use
  :wbthomason/packer.nvim {}
  :godlygeek/tabular {}
  :jiangmiao/autopairs {}
  )

(module config.plugin.gitsigns)

(fn gitsigns-on-attach [bufnr]
  (let [gs package.loaded.gitsigns]
    (λ maplocal [mode l r ?opts]
      (let [opts (or ?opts {})]
        (set opts.buffer bufnr)
        (vim.keymap.set mode l r opts)))
    (maplocal :n "[c" (λ [] (if vim.wo.diff "[c" (do (vim.schedule
                                                       (λ [] (gs.prev_hunk)))
                                                   "<Ignore>"))))
    (maplocal :n "]c" (λ [] (if vim.wo.diff "]c" (do (vim.schedule
                                                       (λ [] (gs.next_hunk)))
                                                   "<Ignore>"))))
    (maplocal [:n :v] :<leader>hs ":Gitsigns stage_hunk<CR>")
    (maplocal [:n :v] :<leader>hr ":Gitsigns reset_hunk<CR>")
    (maplocal :n :<leader>hS gs.stage_buffer {:desc "stage buffer"})
    (maplocal :n :<leader>hu gs.undo_stage_hunk {:desc "undo stage hunk"})
    (maplocal :n :<leader>hR gs.reset_buffer {:desc "reset buffer"})
    (maplocal :n :<leader>hp gs.preview_hunk {:desc "preview hunk"})
    (maplocal :n :<leader>hb
              (λ [] (gs.blame_line {:full true})) {:desc "blame line"})
    (maplocal :n :<leader>tb
              gs.toggle_current_line_blame {:desc "toggle line blame"})
    (maplocal :n :<leader>hd gs.diffthis {:desc "diff this"})
    (maplocal :n :<leader>hD (λ [] (gs.diffthis "~")) {:desc "diff this ~"})
    (maplocal :n :<leader>td gs.toggle_deleted {:desc "toggle deleted"})
    (maplocal [:o :x] :ih ":<C-U>Gitsigns select_hunk<CR>")))

(let [gs (require :gitsigns)]
  (gs.setup {:on_attach gitsigns-on-attach}))





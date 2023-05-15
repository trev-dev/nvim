(module config.plugin.zk)

(let [wk (require :which-key)]
  (wk.register {:prefix :<leader> :z {:name "ZK Notes"}}))

(let [zk (require :zk)]
  (zk.setup {:picker :telescope}))

(let [map vim.keymap.set]
  (map :n :<leader>zf ":ZkNotes<cr>" {:desc "find note"})
  (map :v :<leader>zf ":'<,'>ZkMatch<cr>" {:desc "find note"})
  (map :n :<leader>zn ":ZkNew { title = vim.fn.input('Title: ') }<cr>"
        {:desc "new note"})
  (map :n :<leader>zt ":ZkTags<cr>" {:desc "note tags"}))

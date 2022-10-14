(module tdev.package.zk
  {autoload {utils tdev.utils}})

(let [(ok? zk) (pcall #(require :zk))]
  (when ok?
    (zk.setup {:picker "telescope"})
    (utils.map :<leader>zf "ZkNotes")
    (utils.map :<leader>zn "ZkNew { title = vim.fn.input('Title: ') }")
    (utils.map :<leader>zt "ZkTags")))

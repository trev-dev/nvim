(module tdev.package.todo-comments
  {autoload {utils tdev.utils}})

(let [(ok? todo-comments) (pcall #(require :todo-comments))]
  (when ok?
    (todo-comments.setup)
    (utils.map :<leader>ft "TodoTelescope")
    (utils.map :<leader>qt "TodoQuickFix")))

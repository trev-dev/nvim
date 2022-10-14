(module tdev.package.mkdnflow
  {autoload {utils tdev.utils}})

(let [(ok? mkdnflow) (pcall #(require :mkdnflow))]
  (when ok?
    (mkdnflow.setup
      {:filetypes {:md true :markdown true :org true}
       :mappings {:MkdnNewListItem ["i" "<CR>"]}
       :links {:conceal true :style "markdown"}})))

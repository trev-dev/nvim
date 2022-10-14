(module tdev.package.orgmode)

(let [(ok? orgmode) (pcall #(require :orgmode))]
  (when ok?
    (orgmode.setup
      {:org_agenda_files ["~/Org/*.org"]
       :org_default_notes_file "~/Org/notes.org"})))

(module tdev.package.project-nvim)

(let [(ok? project) (pcall #(require :project_nvim))]
  (when ok?
    (project.setup)))

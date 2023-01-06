(module tdev.package.bufferline
  {autoload {utils tdev.utils}})

(let [(ok? bufferline) (pcall #(require :bufferline))]
  (when ok?
    (bufferline.setup)
    (utils.map :gb "BufferLinePick")))

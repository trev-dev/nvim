;;;; xthml.fnl
;; These settings are for any filetype that represents HTML in one form or
;; or another.  This includes xml, vue, react, svelte, whatever.  This is
;; mostly for setting the stupid ruler.

(module config.filetype.xhtml)

(let [au vim.api.nvim_create_autocmd
      grp (vim.api.nvim_create_augroup :HTMLFiletypes {:clear true})]
  (λ set-ruler [] (set vim.opt_local.colorcolumn "120"))
  (au [:FileType] {:group grp :pattern "vue" :callback set-ruler})
  (au [:FileType] {:group grp :pattern "html" :callback set-ruler})
  (au [:FileType] {:group grp :pattern "jsx" :callback set-ruler})
  (au [:FileType] {:group grp :pattern "svelte" :callback set-ruler})
  (au [:FileType] {:group grp :pattern "xml" :callback set-ruler}))

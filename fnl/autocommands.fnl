(module autocommands
  {autoload {nvim aniseed.nvim}})

(defn- RelativeNumToggle []
  "Toggle relative numbers off and on when a buffer us out or in focus."
  (let [create_augroup vim.api.nvim_create_augroup
        autocmd vim.api.nvim_create_autocmd
        wo nvim.wo
        bo nvim.bo
        relative_toggle (create_augroup "RelativeNumToggle" {:clear true})]

    (autocmd ["BufEnter" "FocusGained" "InsertLeave"]
             {:group relative_toggle
              :pattern "*"
              :callback (lambda []
                          (when wo.number
                            (set wo.relativenumber true)))})
    (autocmd ["BufLeave" "FocusLost" "InsertEnter"]
             {:group relative_toggle
              :pattern "*"
              :callback (lambda [] (set wo.relativenumber false))})))

(defn setup []
  (RelativeNumToggle))

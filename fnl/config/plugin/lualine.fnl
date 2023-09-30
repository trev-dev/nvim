(module config.plugin.lualine
  {autoload {a aniseed.core}})

;;; Colors
(local colors {:bg "#1C1C1C"
               :blue "#51afef"
               :cyan "#008080"
               :darkblue "#081633"
               :fg "#bbc2cf"
               :green "#98be65"
               :magenta "#c678dd"
               :orange "#FF8800"
               :red "#ec5f67"
               :violet "#a9a1e1"
               :yellow "#ECBE7B"})

;;; Conitional Functions
;; A function lookup table for whether or not to show components
(local conditions
       {:buffer_not_empty (λ [] (not= (vim.fn.empty (vim.fn.expand "%:t")) 1))
        :check_git_workspace (λ []
                               (local filepath (vim.fn.expand "%:p:h"))
                               (local gitdir
                                      (vim.fn.finddir ".git" (.. filepath ";")))
                               (and (and gitdir (> (length gitdir) 0))
                                    (< (length gitdir) (length filepath))))
        :hide_in_width (λ [] (> (vim.fn.winwidth 0) 80))
        :in_session (λ [] (not= vim.v.this_session ""))})

;;; Config table
;; Mostly clears out defaults
(local config {:inactive_sections {:lualine_a {}
                                   :lualine_b {}
                                   :lualine_c {}
                                   :lualine_x {}
                                   :lualine_y {}
                                   :lualine_z {}}
               :options {:component_separators ""
                         :globalstatus true
                         :section_separators ""
                         :theme {:inactive {:c {:bg colors.bg :fg colors.fg}}
                                 :normal {:c {:bg colors.bg :fg colors.fg}}}}
               :sections {:lualine_a {}
                          :lualine_b {}
                          :lualine_c {}
                          :lualine_x {}
                          :lualine_y {}
                          :lualine_z {}}})

(λ ins-left [component] (table.insert config.sections.lualine_c component))
(λ ins-right [component] (table.insert config.sections.lualine_x component))

;;; Components
;; The `1` at the front of every component is to balanace out uneven
;; key-value tables in fennel.  Lua has no separation between sequences and
;; key-value stores.
(ins-left {1 (λ [] "▊")
           :color {:fg colors.blue}
           :padding {:left 0 :right 1}})

(ins-left {1 (λ [] "")
           :color (fn []
                    (local mode-color
                           {"\019" colors.orange
                            "\022" colors.blue
                            :! colors.red
                            :R colors.violet
                            :Rv colors.violet
                            :S colors.orange
                            :V colors.blue
                            :c colors.magenta
                            :ce colors.red
                            :cv colors.red
                            :i colors.green
                            :ic colors.yellow
                            :n colors.red
                            :no colors.red
                            :r colors.cyan
                            :r? colors.cyan
                            :rm colors.cyan
                            :s colors.orange
                            :t colors.red
                            :v colors.blue})
                    {:fg (. mode-color (vim.fn.mode))})
           :padding {:right 1}})

(ins-left {1 :filename
           :color {:fg colors.magenta :gui :bold}
           :cond (fn [] (conditions.buffer_not_empty))
           :padding {:left 1 :right 1}})

(ins-left {1 :filesize :cond conditions.buffer_not_empty})
(ins-left [:location])
(ins-left {1 :progress :color {:fg colors.fg :gui :bold}})
(ins-left {1 :diagnostics
           :diagnostics_color {:color_error {:fg colors.red}
                               :color_info {:fg colors.cyan}
                               :color_warn {:fg colors.yellow}}
           :sources [:nvim_diagnostic]
           :symbols {:error " " :info " " :warn " "}})

(print (vim.inspect (vim.lsp.get_active_clients {:bufnr 0})))
(ins-left {1 (λ []
               (let [clients (vim.lsp.get_active_clients {:bufnr 0})]
                 (if (= (next clients) nil) ""
                   (accumulate [names " "
                                _ client (ipairs clients)]
                     (.. names " " client.name)))))
           :color {:fg "#ffffff" :gui :bold}})

(ins-right {1 "o:encoding"
            :color {:fg colors.green :gui :bold}
            :cond conditions.hide_in_width
            :fmt string.upper})

(ins-right {1 :fileformat
            :color {:fg colors.green :gui :bold}
            :fmt string.upper
            :icons_enabled false})

(ins-right {1 :branch :color {:fg colors.violet :gui :bold} :icon ""})

(ins-right {1 :diff
            :cond conditions.hide_in_width
            :diff_color {:added {:fg colors.green}
                         :modified {:fg colors.orange}
                         :removed {:fg colors.red}}
            :symbols {:added " " :modified "柳 " :removed " "}})

(ins-right {1 (λ [] "▊") :color {:fg colors.blue} :padding {:left 1}})

(let [l (require :lualine)]
  (l.setup config))

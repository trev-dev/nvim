(module tdev.package.session-manager
  {autoload {utils tdev.utils}})

(let [(ok? sm) (pcall #(require :session_manager))]
  (when ok?
    (let [conf (require :session_manager.config)
          current_dir conf.AutoloadMode.CurrentDir]
      (sm.setup {:autoload_mode current_dir})
      (utils.map :<leader>pp "SessionManager load_session")
      (utils.map :<leader>pl "SessionManager load_last_session")
      (utils.map :<leader>ps "SessionManager save_current_session")
      (utils.map :<leader>pD "SessionManager delete_session"))))

(module config.filetype.java)

(local jdtls (require :jdtls))
(local home (os.getenv :HOME))
(local mason-home (.. home :/.local/share/nvim/mason))
(local jdtls-path (.. mason-home :/packages/jdtls))
(local lombok-jar (or (os.getenv :LOMBOK_JAR) ""))
(local project-name (vim.fn.fnamemodify (vim.fn.getcwd) ":p:h:t"))
(local workspace-root (.. home :/.cache/jdtls/))
(local workspace (.. workspace-root project-name))

(λ safe-codelens-refresh []
  (let [(_ _) (pcall vim.lsp.codelens.refresh)] nil))

(λ on-attach [_ buff]
  (let [bind vim.keymap.set]
    (λ with-desc [desc] {:buffer buff : desc})

    (safe-codelens-refresh)
    (jdtls.setup_dap {:hotcodereplace :auto})

    (let [dap (require :jdtls.dap)
          setup (require :jdtls.setup)]
      (dap.setup_dap_main_class_configs)
      (setup.add_commands))

    (bind :n :<A-o> jdtls.organize_imports (with-desc "Organize imports"))
    (bind :n :crv jdtls.extract_variable (with-desc "Extract variable"))
    (bind :n :crv jdtls.extract_variable (with-desc "Extract variable"))
    (bind :n :crc jdtls.extract_constant (with-desc "Extract constant"))
    (bind :n :crc jdtls.extract_constant (with-desc "Extract constant"))
    (bind :n :crm jdtls.extract_method (with-desc "Extract method"))
    (bind :n :<localleader>df jdtls.test_class (with-desc "Debug test class"))
    (bind :n :<localleader>dn jdtls.test_nearest_method
          (with-desc "Debug nearest test method"))))

(local java-debug-jar
       (.. mason-home :/packages/java-debug-adapter/extension/server
           :/com.microsoft.java.debug.plugin-*.jar))
(local vsc-java-test-jarfiles
       (.. mason-home :/packages/java-test/extension/server/*.jar))
(local bundles [(vim.fn.glob java-debug-jar 1)])
(vim.list_extend bundles
                 (vim.split (vim.fn.glob vsc-java-test-jarfiles 1) "\n"))

(local config
       {:cmd [:java
              :-Declipse.application=org.eclipse.jdt.ls.core.id1
              :-Dosgi.bundles.defaultStartLevel=4
              :-Declipse.product=org.eclipse.jdt.ls.core.product
              :-Dlog.protocol=true
              :-Dlog.level=ALL
              :-Xms1g
              :--add-modules=ALL-SYSTEM
              :--add-opens
              :java.base/java.util=ALL-UNNAMED
              :--add-opens
              :java.base/java.lang=ALL-UNNAMED
              (.. "-javaagent:" lombok-jar)
              :-jar
              (vim.fn.glob (.. jdtls-path
                               :/plugins/org.eclipse.equinox.launcher_*.jar))
              :-configuration
              (.. jdtls-path :/config_linux)
              :-data
              workspace]
        :init_options {: bundles}
        :on_attach on-attach
        :root_dir ((. (require :jdtls.setup) :find_root) [:.git
                                                          :mvnw
                                                          :gradlew
                                                          :pom.xml])
        :settings {:java
                   {:codeGeneration
                    {:toString
                     {:template (.. "${object.className}"
                                    "{${member.name()}=${member.value}, "
                                      "${otherMembers}}")}}
                    :completion {:favoriteStaticMembers
                                 [:org.hamcrest.MatcherAssert.assertThat
                                  :org.hamcrest.Matchers.*
                                  :org.hamcrest.CoreMatchers.*
                                  :org.junit.jupiter.api.Assertions.*
                                  :java.util.Objects.requireNonNull
                                  :java.util.Objects.requireNonNullElse
                                  :org.mockito.Mockito.*]}
                    :configuration {:runtimes {}}
                    :contentProvider {:preferred :fernflower}
                    :eclipse {:downloadSources true}
                    :implementationsCodeLens {:enabled true}
                    :inlayHints {:parameterNames {:enabled :all}}
                    :maven {:downloadSources true}
                    :references {:includeDecompiledSources true}
                    :referencesCodeLens {:enabled true}
                    :signatureHelp {:enabled true}
                    :sources {:organizeImports {:starThreshold 9999
                                                :staticStarThreshold 9999}}}}})
(vim.api.nvim_create_autocmd [:BufWritePost]
                             {:callback safe-codelens-refresh
                              :pattern [:*.java]})

(let [au vim.api.nvim_create_autocmd
      augrp vim.api.nvim_create_augroup]
  (au [:FileType] {:group (augrp :JDTLS {:clear true})
                   :pattern "java"
                   :callback (λ []
                               (jdtls.start_or_attach config)
                               (set vim.opt_local.colorcolumn "100"))}))


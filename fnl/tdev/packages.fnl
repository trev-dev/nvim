;; Borrowed from Olical/magic-kit
;; https://github.com/Olical/magic-kit/blob/main/fnl/magic/plugin.fnl

(module tdev.packages
  {autoload {a aniseed.core
            packer packer}})

(defn- safe-require-plugin-config [name]
  "Safely require a module under the magic.plugin.* prefix. Will catch errors
  and print them while continuing execution, allowing other plugins to load
  even if one configuration module is broken."
  (let [(ok? val-or-err) (pcall require (.. "tdev.package." name))]
    (when (not ok?)
      (print (.. "Plugin config error: " val-or-err)))))

(defn req [name]
  "A shortcut to building a require string for your plugin
  configuration. Intended for use with packer's config or setup
  configuration options. Will prefix the name with `tdev.package.`
  before requiring."
  (.. "require('tdev.package." name "')"))

(defn use [...]
  "Iterates through the arguments as pairs and calls packer's use function for
  each of them. Works around Fennel not liking mixed associative and sequential
  tables as well.
  This is just a helper / syntax sugar function to make interacting with packer
  a little more concise."
  (let [pkgs [...]]
    (packer.init
      {:git {:clone_timeout false}
       :max_jobs 4})
    (packer.startup
      (fn [use]
        (for [i 1 (a.count pkgs) 2]
          (let [name (. pkgs i)
                opts (. pkgs (+ i 1))]
            (-?> (. opts :mod) (safe-require-plugin-config))
            (use (a.assoc opts 1 name)))))))

  nil)

(module config.util)

(defn to-assoc [key-value-pairs]
  "Create an assoc array of conses from a key-value pair table."
  (let [assoc []]
    (each [k v (pairs key-value-pairs)]
      (table.insert assoc [k v]))
    assoc))

(defn merge [a b]
  "Merge two tables."
  (let [new a]
    (each [k v (pairs b)]
      (tset new k v))
    new))

(defn safe-require [name]
  "Safely require a module without breaking the rest of the init."
  (let [(ok? val-or-err) (pcall require name)]
    (when (not ok?)
      (print (.. "Plugin config error: " val-or-err)))))

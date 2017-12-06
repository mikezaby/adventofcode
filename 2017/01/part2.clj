(def input (clojure.string/trim-newline (slurp "2017/01/input.txt")))

(println (reduce +
  (map #(Character/digit (first %) 10)
    (filter #(= (first %) (second %))
      (map (fn [a b] [a b]) input (take (count input) (drop (quot (count input) 2) (cycle input))))))))

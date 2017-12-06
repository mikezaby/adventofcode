(def input (clojure.string/trim-newline (slurp "2017/01/input.txt")))

(println (reduce +
  (map #(Character/digit (first %) 10)
    (filter #(= (first %) (second %))
      (map-indexed #(vector %2 (get input (mod (+ %1 1) (count input)))) input)))))

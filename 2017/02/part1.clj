(require '[clojure.string :as str])

(def input
  (map (fn [line]
         (map (fn [str] (Integer/parseInt str)) (str/split line #"\t")))
       (str/split-lines (slurp "2017/02/input.txt"))))

(defn diff [line]
  (- (apply max line) (apply min line)))

(println (reduce + (map (fn [line] (diff line)) input)))

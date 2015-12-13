@clojure = File.new('1.data', "r").gets.chomp
a = @clojure.chars.sort.index(')')
puts a
puts(a - (@clojure.length - a))

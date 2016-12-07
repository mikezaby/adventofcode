clojure = File.new('1.data', "r").gets.chomp
floor = 0

clojure.each_char.with_index(1) do |c,i|
  c == '(' ? floor+=1 : floor-=1
  if floor == -1
    puts i
    break
  end
end

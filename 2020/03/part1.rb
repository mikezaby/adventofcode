mod = @data.first.strip.length
puts mod
x = 0
inc = 3

@output = @data.reduce(0) do |sum, line|
  x = (x + inc) % mod

  line[x] == "#" ? sum.succ : sum
end

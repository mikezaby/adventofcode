geology = @data.map(&:strip)
mod = geology.first.length

inc = [
  [1, 1],
  [3, 1],
  [5, 1],
  [7, 1],
  [1, 2]
]

@output = inc.map do |x_inc, y_inc|
  x = 0

  geology.each_with_index.reduce(0) do |sum, (line, index)|
    next sum if index == 0 || (index % y_inc) != 0

    x = (x + x_inc) % mod

    line[x] == "#" ? sum.succ : sum
  end
end.reduce(&:*)

adapters = @data.map(&:strip).map(&:to_i).sort
adapters.prepend(0)
adapters.append(adapters.max + 3)

adapters = adapters.each_cons(2).select { |a,b| (b - a) == 1 }.map(&:first)

combinations_per_count = {
  1 => 2,
  2 => 4,
  3 => 7
}

@output = adapters.reverse.each_cons(2).select { |a,b| (a - b) == 1 }.map(&:first)
  .reduce([]) do |arr, num|
    arr.any? && (arr.last.last - 1) == num ? arr.last.push(num) : arr.push([num])

    arr
  end.reduce(1) { |comb, group| comb *  combinations_per_count[group.count] }

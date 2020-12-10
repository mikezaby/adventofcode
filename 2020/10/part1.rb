adapters = @data.map(&:strip).map(&:to_i).sort
adapters.prepend(0)
adapters.append(adapters.max + 3)

@output = adapters
  .each_cons(2)
  .group_by { |a,b| b - a }
  .values
  .map(&:count)
  .reduce(:*)

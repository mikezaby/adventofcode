positions = @data.first.split(",").map(&:to_i)
  .group_by(&:itself)
  .map { |n, arr| [n, arr.count] }.to_h


def fuel(crab_positions, position)
  crab_positions.reduce({}) do |moves, (crab_position, count)|
    moves[crab_position] = (crab_position - position).abs * count
    moves
  end.values.sum
end

def min_fuel(crab_positions)
  max_position = crab_positions.keys.max

  (0..max_position).map { |position| fuel(crab_positions, position) }.min
end

@output = min_fuel(positions)

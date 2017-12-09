require 'set'

memory_banks = File.read('2017/06/input.txt').split("\t").map(&:to_i)
banks_count = memory_banks.count
state = Set.new([memory_banks])

loop do
  max_blocks = memory_banks.max
  bank_index = memory_banks.index(max_blocks)
  memory_banks[bank_index] = 0

  ((bank_index + 1)..(bank_index + max_blocks)).each { |i| memory_banks[i % banks_count] += 1 }

  if !state.add?(memory_banks)
    break state.count
  end
end

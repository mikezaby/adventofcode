input = File.read('./input.txt').each_line.map { |line| line.to_i }
require 'set';
input_count = input.count

initial_frequency_table = input.reduce([]) do |table, num|
  freq = table.last || 0
  table.push(freq + num)
end

find_frequency = ->(last_frequency = initial_frequency_table.last, frequencies = initial_frequency_table) do
  frequencies.push(*initial_frequency_table.map { |freq| freq + last_frequency })

  if frequencies.count != frequencies.uniq.count
    set_freq = Set.new

    return frequencies.find { |freq| !set_freq.add?(freq) }
  end

  find_frequency.call(frequencies.last, frequencies)
end

puts find_frequency.call()

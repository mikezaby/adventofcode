checksum = File.read('./input.txt').each_line.map do |line|
  line.chars.group_by(&:itself).values.map { |group| group.count }.uniq.
    select { |count| count == 2 || count == 3  }
end.flatten.group_by(&:itself).map { |_, v| v.count }.reduce(:*)

puts checksum

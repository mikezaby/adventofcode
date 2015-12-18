require '../file_helper.rb'

places = []

distances = FileHelper.new('9.data').reduce({}) do |distances, line|
  from, _, to, _, distance = line.split
  distances.merge! [from, to].sort => distance.to_i
end

permutations = []
distances.keys.flatten.uniq.permutation do |p|
  permutations.push p[0...-1].zip(p[1..-1]) if p[0] < p[-1]
end

puts permutations.map { |permutation| permutation.reduce(0) {|sum, dist| sum + distances[dist.sort] } }.min

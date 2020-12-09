data = @data.map(&:strip).map(&:to_i)

preamble = 25

@output = data[preamble..-1].each_with_index.find do |num, i|
  index = i + preamble
  !data[i...index].combination(2).lazy.find { |comb| comb.sum == num }
end

data = @data.map(&:strip).map(&:to_i)

preamble = 25

invalid_num = data[preamble..-1].each_with_index.find do |num, i|
  index = i + preamble
  !data[i...index].combination(2).lazy.find { |comb| comb.sum == num }
end.first

def find_encryption(data, invalid_num, index = 0, size = 2)
  loop do
    set = data[index...(index+size)]
    contiguous_sum = set.sum

    if contiguous_sum == invalid_num
      break set
    elsif contiguous_sum < invalid_num
      size += 1
    else
      size = 2
      index += 1
    end
  end
end

set = find_encryption(data, invalid_num)
@output = set.min + set.max

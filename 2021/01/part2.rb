def count_incs(data, index = 1, count = 0)
  return count if data[index].nil?

  count += 1 if data[index] > data[index - 1]

  count_incs(data, index + 1, count)
end

data = @data.map(&:strip).map(&:to_i)
data = (0..(data.count-3)).map { |i| data[i] + data[i+1] + data[i+2] }

@output = count_incs(data)

def count_incs(data, index = 1, count = 0)
  return count if data[index].nil?

  count += 1 if data[index] > data[index - 1]

  count_incs(data, index + 1, count)
end

@output = count_incs(@data.map(&:strip).map(&:to_i))

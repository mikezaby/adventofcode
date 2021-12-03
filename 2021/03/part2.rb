def common_bits(data, type)
  common = data
    .map { |line| Vector[*line.map { |b| b == "0" ? -1 : 1 }] }
    .reduce(:+)
    .map { |n| n >= 0 ? "1" : "0" }.to_a

  type == :common ? common : common.map { |b| b == "0" ? "1" : "0" }
end

def filtering(data, type, index = 0)
  return data.first if data.one?

  matrix = common_bits(data, type)
  filtered_data = data.select { |binary| binary[index] == matrix[index] }
  filtering(filtered_data, type, index + 1)
end

data = @data.map(&:chars)
oxygen = filtering(data, :common)
co2 = filtering(data, :list_common)

@output = oxygen.join.to_i(2) * co2.join.to_i(2)

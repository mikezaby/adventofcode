def gama_rate(binary_number)
  rate = binary_number.reduce(:+)
  rate.map { |n| n > 0 ? 1 : 0 }.to_a
end

def epsilon_rate(gama_rate)
  gama_rate.map { |b| b == 0 ? 1 : 0 }
end

data = @data.map { |line| Vector[*line.chars.map { |b| b == "0" ? -1 : 1 }] }
gama_rate_val = gama_rate(data)
epsilon_rate_val = epsilon_rate(gama_rate_val)

@output = gama_rate_val.join.to_i(2) * epsilon_rate_val.join.to_i(2)

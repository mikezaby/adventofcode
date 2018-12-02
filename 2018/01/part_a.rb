input = File.read('./input.txt').each_line.map { |line| line.to_i }

p input.reduce(:+)

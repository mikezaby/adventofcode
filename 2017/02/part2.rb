input = File.read('./input.txt').each_line.map { |line| line.split("\t").map(&:to_i) }

devide = ->(first, *rest) do
  match = rest.find do |num|
    first % num == 0 || num % first == 0
  end

  if match
    return first > match ? (first / match) : (match / first)
  end

  devide.(*rest)
end

input.reduce(0) { |sum, line| sum + devide.(*line) }

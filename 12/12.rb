require '../file_helper.rb'
require 'json'

def extract_nums(input)
  case input
  when Hash then extract_nums(input.values)
  when Array then input.reduce(0) { |sum, v| sum + extract_nums(v) }
  when Integer then input
  else 0
  end
end

puts extract_nums(JSON.parse(FileHelper.new('12.data').first))

require '../file_helper.rb'

diff = FileHelper.new('8.data').reduce(0) do |diff, line|
  diff += line.chomp.length - eval(line).length
end

puts diff

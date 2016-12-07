require '../file_helper.rb'

diff = FileHelper.new('8.data').reduce(0) do |diff, line|
  line.chomp!
  diff += line.gsub("\\", "\\\\\\").gsub('"', '\"').length - line.chomp.length + 2
end

puts diff

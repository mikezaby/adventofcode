groups = File.read('2017/09/input.txt')

groups.gsub!(/!./, '')
groups.gsub!(/<.*?>/, '')
groups.gsub!("\n", '')
groups.gsub!(',', '')
groups.gsub!('}{', '},{')

sum = 0

loop do
  groups.gsub!(/{(\d+,?)*}/) do |a|
    replacled_number = a.gsub(/{|}/, '').split(',').map(&:to_i).reduce(:+).to_i + 1
    sum += replacled_number

    replacled_number
  end

  p groups
  break p sum if groups.match(/\d+$/)
end

require './file_helper'
data_path = File.join(File.dirname(__FILE__), 'data.txt')
file = FileHelper.new(data_path)

sum = 2020

all_expenses = file.map(&:to_i)

expense = all_expenses.find do |exp|
  opposite_value = sum - exp

  all_expenses.include?(opposite_value)
end

puts (expense * (2020 - expense))

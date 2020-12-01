require './file_helper'
data_path = File.join(File.dirname(__FILE__), 'data.txt')
file = FileHelper.new(data_path)

sum = 2020

answer = file
  .map(&:to_i)
  .permutation(3)
  .find{ |a,b,c| (a + b + c) == sum }
  .reduce(:*)

puts answer

sum = 2020

@output = @data
  .map(&:to_i)
  .permutation(3)
  .find{ |a,b,c| (a + b + c) == sum }
  .reduce(:*)

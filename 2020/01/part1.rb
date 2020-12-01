sum = 2020

all_expenses = @data.map(&:to_i)

expense = all_expenses.find do |exp|
  opposite_value = sum - exp

  all_expenses.include?(opposite_value)
end

@output = (expense * (2020 - expense))

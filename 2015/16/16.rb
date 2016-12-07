require '../file_helper'

requirements = eval(FileHelper.new('16.gift.data').to_a.join)
aunts = eval(FileHelper.new('16.data').to_a.join)

puts aunts.find { |_, value| value.all? { |k, v| eval("#{v}#{requirements[k]}") } }.first

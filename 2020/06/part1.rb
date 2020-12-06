@output = @data.reduce([[]]) do |group, value|
  group.push([]) if value.blank?

  group[-1] += value.strip.chars

  group
end.sum { |group| group.uniq.count }

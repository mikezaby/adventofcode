require "rubygems/text"
levenshtein_distance = Class.new.extend(Gem::Text).method(:levenshtein_distance)

common_letters = ->(ids) do
  first_id = ids.pop

  second_id = ids.find { |id| levenshtein_distance.call(id, first_id) == 1 }

  if second_id
    return (first_id.chars - (first_id.chars - second_id.chars)).join
  end

  common_letters.call(ids)
end

puts common_letters.call(File.read('./input.txt').each_line.map(&:chomp))

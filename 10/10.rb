def look_and_say(string)
  char_counts = []

  string.chars.each do |new_char|
    char_count = char_counts.last

    if char_count && char_count.last == new_char
      char_count[0] += 1
    else
      char_counts.push [1, new_char]
    end
  end

  char_counts.join
end

final = 50.times.reduce('1113222113') do |string|
  look_and_say(string)
end

puts final.length

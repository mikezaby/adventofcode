def scan(data)
  data.map { |line| line.split(" | ").map { |s| s.split } }
end

def count(digits)
  digits.count { |d| [2, 3, 4, 7].include?(d.length)  }
end

@output =  count(scan(@data).map(&:last).flatten)

passphrases = File.read('2017/04/input.txt').each_line.map { |line| line.split(' ') }

puts passphrases.count { |phrase| phrase.count == phrase.uniq.count }

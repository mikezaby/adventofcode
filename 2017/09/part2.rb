groups = File.read('2017/09/input.txt')

groups.gsub!(/!./, '')
groups.gsub!("\n", '')

p groups.scan(/<(.*?)>/).reduce(0) { |sum, string| sum + string.first.size }

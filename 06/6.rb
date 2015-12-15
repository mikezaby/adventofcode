class Lcd
  attr_reader :file, :monitor

  def initialize(file_path)
    @file = File.new(file_path, "r")
    @monitor = Array.new(1000) { Array.new(1000, 0) }
  end

  def load_instractions
    file.each_line do |line|
      cmd, from, to = parse(line.chomp.split)
      (from[1]..to[1]).each do |y|
        (from[0]..to[0]).each do |x|
          send(cmd, x, y)
        end
      end
    end
  end

  def parse(tokens)
    [command(tokens), tokens.first.split(',').map(&:to_i), tokens.last.split(',').map(&:to_i)]
  end

  def command(tokens)
    cmd = tokens.shift
    cmd == 'toggle' ? cmd : tokens.shift
  end

  def on(x, y)
    monitor[y][x] += 1
  end

  def off(x, y)
    return if monitor[y][x].zero?

    monitor[y][x] -= 1
  end

  def toggle(x, y)
    monitor[y][x] += 2
  end
end

lcd = Lcd.new('6.data')
lcd.load_instractions
puts lcd.monitor.flatten.reduce(:+)

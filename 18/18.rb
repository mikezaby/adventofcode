require '../file_helper'

class Lcd
  attr_reader :grid, :always_on
  attr_accessor :monitor

  def initialize(file_path)
    @monitor = FileHelper.new(file_path).map { |row| row.chars.map { |l| l == '#' } }
    @grid = @monitor.count - 1
    @always_on = [[0, @grid], [@grid, 0], [0, 0], [@grid, @grid]]
    @always_on.each { |point| @monitor[point.last][point.first] = true }
  end

  def step(n = 1)
    self.monitor = (0..grid).map { |y| (0..grid).map { |x| step_light(x, y) } }
    n <= 1 ? self : step(n-1)
  end

  def step_light(x,y)
    return true if @always_on.include? [x, y]

    neighbors = range(y).map { |yy| range(x).map { |xx| monitor[yy][xx] } }.flatten

   if monitor[y][x]
      neighbors.count(&:itself).between?(3, 4)
    else
      neighbors.count(&:itself) == 3
    end
  end

  def range(n)
    ([0, n-1].max..[grid, n+1].min)
  end
end

lcd = Lcd.new('input.txt')
puts lcd.step(100).monitor.flatten.count(&:itself)

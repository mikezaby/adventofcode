DATA = @data

module Map
  def self.find(x, y)
    return nil if x < 0 || y < 0 || x >= octopuses.count || y >= octopuses.first.count

    octopuses[x][y]
  end

  def self.octopuses
    @octopuses ||= DATA.map.with_index do |line, x|
      line.chars.map.with_index { |value, y| Octopus.new([x,y], value.to_i) }
    end
  end

  def self.flatten_octopuses
    @flatten_octopuses ||= octopuses.flatten
  end

  def self.count_flashes(step, flashes = 0)
    flatten_octopuses.each(&:initial_inc)
    flatten_octopuses.select(&:flashed?).each(&:flash_effect)
    flashes += flatten_octopuses.count(&:flashed?)

    step == 1 ? flashes : count_flashes(step - 1, flashes)
  end
end

class Octopus
  attr_reader :x, :y
  attr_accessor :value

  def initialize(point, value)
    @x, @y = point
    @value = value
  end

  def flashed?
    value == 0
  end

  def initial_inc
    self.value = value == 9 ? 0 : value + 1
  end

  def flash_effect
    neighbors.each(&:flash_inc)
  end

  def flash_inc
    return if flashed?

    self.value = value == 9 ? 0 : value + 1

    flash_effect if flashed?
  end

  def neighbors
    return @neighbors if @neighbors

    @neighbors = []

    (x-1..x+1).each do |xx|
      (y-1..y+1).each do |yy|
        next if xx == x && yy == y

        neighbor = Map.find(xx, yy)
        @neighbors.push(neighbor) if neighbor
      end
    end

    @neighbors
  end

  def inspect
    "Point { x: #{x}, y: #{y}, v: #{value} }"
  end
end

@output = Map.count_flashes(100)

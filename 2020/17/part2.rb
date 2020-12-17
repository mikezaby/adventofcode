class PoketDimension
  ACTIVE_RANGE = (2..3)

  def initialize(initial_state)
    @cubes = Hash.new { |h,k| h[k] = Cube.new(k, self) }
    parse(initial_state)
  end

  def cubes(*point)
    if point.present?
      @cubes[point]
    else
      @cubes
    end
  end

  def apply_values
    cubes.each { |k, cube| cube.apply }
  end

  def cycle(n)
    n.times do |i|
      cubes.values.select(&:active?).each(&:neighbors)

      cubes.values.each do |cube|
        if cube.active?
          cube.next_value = ACTIVE_RANGE.include?(cube.neighbors.count(&:active?))
        else
          cube.next_value = cube.neighbors.count(&:active?) == 3
        end
      end

      apply_values
    end
  end

  def inspect
    "PoketDimension"
  end

  private

  def parse(initial_state)
    initial_state
      .lines
      .each_with_index do |row, x|
        row.strip.chars.each_with_index do |char, y|
          cubes(x, y, 0, 0).value = (char == "#")
        end
      end
  end
end

class Cube
  attr_reader :x, :y, :z, :w, :poket_dimension
  attr_accessor :next_value, :value

  def initialize(point, poket_dimension)
    @x, @y, @z, @w = point
    @poket_dimension = poket_dimension
  end

  def apply
    self.value = next_value
  end

  def active?
    value
  end

  def neighbors
    return @neighbors if @neighbors

    @neighbors = []

    (x-1..x+1).each do |xx|
      (y-1..y+1).each do |yy|
        (z-1..z+1).each do |zz|
          (w-1..w+1).each do |ww|
            next if xx == x && yy == y && zz == z && ww == w

            @neighbors.push(poket_dimension.cubes[[xx, yy, zz, ww]])
          end
        end
      end
    end

    @neighbors
  end

  def inspect
    value
  end
end

cube = PoketDimension.new(@data.file.read)
cube.cycle(6)
@output = cube.cubes.values.count(&:active?)

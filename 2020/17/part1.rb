class PoketDimension
  ACTIVE_RANGE = (2..3)

  def initialize(initial_state)
    @cubes = Hash.new { |h,k| h[k] = Cube.new(k) }
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
    cubes.values.each(&:apply)
  end

  def cycle(n)
    n.times do
      cubes.values.map { |cube| neighbors(cube) }.flatten.uniq.each do |cube|
        neighbors = neighbors(cube)

        if cube.active?
          cube.next_value = ACTIVE_RANGE.include?(neighbors.count(&:active?))
        else
          cube.next_value = neighbors.count(&:active?) == 3
        end
      end

      apply_values
    end
  end

  def neighbors(cube)
    cube.neighbors.map { |point| cubes(*point) }
  end

  private

  def parse(initial_state)
    initial_state
      .lines
      .each_with_index do |row, x|
        row.strip.chars.each_with_index do |char, y|
          cubes(x, y, 0).value = (char == "#")
        end
      end
  end
end

class Cube
  attr_reader :x, :y, :z
  attr_accessor :next_value, :value

  def initialize(point)
    @x, @y, @z = point
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
          next if xx == x && yy == y && zz == z

          @neighbors.push([xx, yy, zz])
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

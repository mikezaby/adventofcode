class Spiral
  attr_accessor :fill_count, :direction, :side_width, :point, :map, :my_square

  NEIGHBORS = [[0, 1], [0, -1], [1, 0], [1, -1], [-1, 0], [-1, 1], [-1, -1], [1, 1]]

  MOVES = {
    right: [1, 0],
    up: [0, 1],
    left: [-1, 0],
    down: [0, -1]
  }

  def initialize(my_square)
    @fill_count = 0
    @side_width = 0
    @second_time = true

    @point = [0, 0]
    @map = Hash.new(0)
    @map[@point] = 1
    @my_square = my_square
  end

  def move
    @move ||= [:right, :up, :left, :down].cycle
  end

  def new_point(input_point)
    [point, input_point].transpose.map {|x| x.reduce(:+)}
  end

  def neighbors
    NEIGHBORS.map { |n| map[new_point(n)] }
  end

  def next_point
    if fill_count.zero?
      self.direction = MOVES[move.next]
      self.fill_count = side_width
      self.side_width += 1 if second_time
    else
      self.fill_count -= 1
    end

    self.point = new_point(direction)
  end

  def second_time
    @second_time = !@second_time
  end

  def fill_map
    next_point

    current_value = map[point] = neighbors.reduce(:+)

    return current_value if current_value > my_square

    fill_map
  end
end

spiral = Spiral.new(312051)
puts spiral.fill_map

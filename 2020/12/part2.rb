class Ship
  POLES = ['E', 'S', 'W', 'N']

  attr_accessor :point
  attr_reader :instructions, :waypoint

  def initialize(data)
    @point = [0,0]
    @waypoint = Waypoint.new(10, 1)
    parse_instructions(data)
  end

  def follow_instructions
    @instructions.each do |act, num|
      if POLES.include?(act)
        waypoint.move(act, num)
      elsif act == 'F'
        self.point = point.zip(waypoint.point.map { |i| i * num }).map(&:sum)
      else
        waypoint.rotate(act, num)
      end
    end
  end

  def distance
    point.map(&:abs).sum
  end

  private

  def parse_instructions(data)
    @instructions = data.map(&:strip)
      .map { |inst| inst.match(/(.)(\d+)/).captures }
      .map { |act, num| [act, num.to_i] }
  end
end

class Waypoint
  attr_accessor :point

  def initialize(x, y)
    @point = [x, y]
  end

  def move(act, num)
    sign = (act == 'W' || act == 'S') ? :- : :+
    index = (act == 'W' || act == 'E') ? 0 : 1

    point[index] = point[index].send(sign, num)
  end

  def rotate(dir, deg)
    deg = 360 - deg if dir == 'L'

    (deg / 90).times { rotate_90 }
  end

  def rotate_90
    self.point = [point[1], -point[0]]
  end
end

ship = Ship.new(@data)
ship.follow_instructions
@output = ship.distance

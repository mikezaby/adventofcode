class GameOfSeats
  attr_reader :history, :row_count, :column_count
  attr_accessor :seats

  def initialize(data)
    parse(data)
    @history = []
    @row_count = seats.count
    @column_count = seats.first.count
  end

  def cycle
    history.push(seats)

    new_seats = []

    (0...row_count).each do |x|
      new_seats.push([])
      (0...column_count).each do |y|
        new_seats.last.push(apply_rule(x, y))
      end
    end

    self.seats = new_seats

    self
  end

  def stabilize
    loop do
      cycle

      break self if seats == history.last
    end
  end

  def inspect
    seats.map { |l| l.map(&:to_s).join }.join("\n")
  end

  private

  def apply_rule(x, y)
    seat = seats[x][y].dup
    return seat if seat.floor?

    neighbors = find_neighbors(x, y)

    if seat.free?
      neighbors.none? { |nseat| nseat.occupied? } && seat.toggle!
    else
      neighbors.count { |nseat| nseat.occupied? } >= 5 && seat.toggle!
    end

    seat
  end

  def find_neighbors(x,y)
    neighbors = []

    (x-1..x+1).each do |xx|
      (y-1..y+1).each do |yy|
        next if xx == x && yy == y
        next if !in_range?(xx, yy)

        seat = find_see_seat(x, y, xx, yy)
        next if !seat

        neighbors.push(seat)
      end
    end

    neighbors
  end

  def find_see_seat(x, y, xx, yy)
    return if !in_range?(xx, yy)

    nseat = seats[xx][yy]
    return nseat if !nseat.floor?

    if yy != y
      yy = yy > y ? (yy + 1) : (yy - 1)
    end
    if xx != x
      xx = xx > x ? (xx + 1) : (xx - 1)
    end

    find_see_seat(x, y, xx, yy)
  end

  def in_range?(x,y)
    x >= 0 && y >= 0 && x < row_count && y < column_count
  end

  def parse(data)
    @seats = data.map(&:strip).map { |line| line.chars.map { |v| Seat.new(v) } }
  end
end

class Seat
  STATES = {
    "." => :floor,
    "#" => :occupied,
    "L" => :free
  }

  attr_accessor :value

  def initialize(initial_value)
    @value = STATES[initial_value]
  end

  def toggle!
    self.value = free? ? :occupied : :free
  end

  def free?
    value == :free
  end

  def occupied?
    value == :occupied
  end

  def floor?
    value == :floor
  end

  def ==(seat)
    value == seat.value
  end

  def to_s
    STATES.find { |k,v| v == value }.first
  end
end

gos = GameOfSeats.new(@data)
@output = gos.stabilize.seats.flatten.count(&:occupied?)

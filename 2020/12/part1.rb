class Ship
  POLES = ['E', 'S', 'W', 'N']

  attr_accessor :facing
  attr_reader :moves, :instructions

  def initialize(data)
    @facing = "E"
    @moves = Hash.new { |h,k| h[k] = 0 }
    parse_instructions(data)
  end

  def follow_instructions
    @instructions.each do |act, num|
      if POLES.include?(act)
        moves[act] += num
      elsif act == 'F'
        moves[facing] += num
      elsif act == 'R'
        self.facing = POLES[(POLES.index(facing) + num / 90) % 4]
      elsif act == 'L'
        self.facing = POLES[(POLES.index(facing) - num / 90)]
      else
        raise 'Not supported'
      end
    end
  end

  def distance
    (moves['E'] - moves['W']).abs + (moves['N'] - moves['S']).abs
  end

  private

  def parse_instructions(data)
    @instructions = data.map(&:strip)
      .map { |inst| inst.match(/(.)(\d+)/).captures }
      .map { |act, num| [act, num.to_i] }
  end
end

ship = Ship.new(@data)
ship.follow_instructions
@output = ship.distance

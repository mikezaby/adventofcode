require '../../file_helper.rb'

class Walker
  DIRECTIONS = [:north, :east, :south, :west]

  MOVES = {
    north: { axis: :x, L: -1, R: 1 },
    east: { axis: :y, L: 1, R: -1 },
    south: { axis: :x, L: 1, R: -1 },
    west: { axis: :y, L: -1, R: 1 }
  }

  def initialize(instructions_file)
    @instructions = FileHelper.new(instructions_file).first.gsub(' ', '').split(',').
                               map { |i| [i[0].to_sym, i[1..-1].to_i] }
  end

  def follow_instructions(until_revisit = false)
    self.direction = :north
    self.location = { x: 0, y: 0 }
    self.points = {[0,0] => true}

    instructions.each do |instruction|
      prev_location = location.dup

      move(instruction)

      return if until_revisit && check_points(prev_location)
    end
  end

  def blocks
    location[:x].abs + location[:y].abs
  end

  private

  attr_accessor :instructions, :direction, :location, :points

  def move(instruction)
    location[MOVES[direction][:axis]] += MOVES[direction][instruction.first] * instruction.last

    next_direction = instruction.first == :L ? -1 : 1
    self.direction = DIRECTIONS[(DIRECTIONS.index(direction) + next_direction) % 4]
  end

  def check_points(prev_location)
    xx = [prev_location[:x], location[:x]].sort
    yy = [prev_location[:y], location[:y]].sort

    (yy.first..yy.last).each do |y|
      (xx.first..xx.last).each do |x|
        next if x == prev_location[:x] && y == prev_location[:y]

        if points[[y,x]]
          location[:x] = x
          location[:y] = y
          return true
        else
          points[[y,x]] = true
        end
      end
    end

    return false
  end
end

walker = Walker.new('1.txt')
walker.follow_instructions(true)
puts walker.blocks

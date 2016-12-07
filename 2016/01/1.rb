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

  def follow_instructions
    self.direction = :north
    self.location = { x: 0, y: 0 }

    instructions.each { |instruction| move(instruction) }
  end

  def blocks
    location[:x].abs + location[:y].abs
  end

  private

  attr_accessor :instructions, :direction, :location

  def move(instruction)
    location[MOVES[direction][:axis]] += MOVES[direction][instruction.first] * instruction.last

    next_direction = instruction.first == :L ? -1 : 1
    self.direction = DIRECTIONS[(DIRECTIONS.index(direction) + next_direction) % 4]
  end
end

walker = Walker.new('1.txt')
walker.follow_instructions
puts walker.blocks

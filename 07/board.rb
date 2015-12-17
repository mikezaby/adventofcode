require './operator.rb'
require './wire.rb'

class Board
  attr_reader :file

  OPERATORS = "(AND|OR|NOT|RSHIFT|LSHIFT)"

  def initialize(file_path)
    @file = File.new(file_path, "r")
    @wires = {}
  end

  def load_instructions
    file.each_line do |line|
      exec(line.chomp)
    end
  end

  def exec(string)
    operation, set_variable = string.split(' -> ')

    op = operation.match(OPERATORS).to_a.first
    inputs = op ? operation.sub(op, '').split : [operation]
    inputs = inputs.map { |input| Integer(input) rescue wires(input)  }

    wires(set_variable).input = op ? Operator.new(op, inputs) : inputs.first
  end

  def wires(name)
    @wires[name] ||= Wire.new
  end
end

board = Board.new('instructions.data')
board.load_instructions
puts board.wires('a').value

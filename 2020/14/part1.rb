class Program
  attr_reader :instructions, :memory
  attr_accessor :mask

  BIT = 36

  def initialize(instructions)
    @instructions = instructions.map(&:strip)
    @memory = {}
  end

  def run
    instructions.each { |command| executu(command) }
  end

  private

  def executu(command)
    type, value = command.split(" = ")

    if type == 'mask'
      self.mask = value.chars
    else
      index = type.match(/(\d+)/).captures.first.to_i

      memory[index] = mask
        .zip(value.to_i.to_s(2).rjust(BIT, '0').chars)
        .map { |m, v| m == 'X' ? v : m }
        .join.to_i(2)
    end
  end
end

program = Program.new(@data)
program.run
@output = program.memory.values.sum

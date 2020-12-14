class Program
  attr_reader :instructions, :memory
  attr_accessor :mask, :mask_x_count

  BIT = 36

  def initialize(instructions)
    @instructions = instructions.map(&:strip)
    @memory = {}
    @posibilities = {}
  end

  def run
    instructions.each { |command| executu(command) }
  end

  private

  def posibilities(count)
    @posibilities[count] ||= 2.pow(count).times.map { |i| i.to_s(2).rjust(count, '0').chars }
  end

  def executu(command)
    type, value = command.split(" = ")

    if type == 'mask'
      self.mask = value.chars
      self.mask_x_count = mask.count { |bit| bit == "X" }
    else
      index = type.match(/(\d+)/).captures.first.to_i
      value = value.to_i

      index = mask.zip(index.to_i.to_s(2).rjust(BIT, '0').chars)
      index = index.map do |m, v|
        case m
        when '0'
          v
        when 'X'
          "%s"
        when "1"
          "1"
        end
      end.join

      posibilities(mask_x_count).each do |posibol|
        memory[(index % posibol).to_i(2)] = value
      end
    end
  end
end

program = Program.new(@data)
program.run
@output = program.memory.values.sum

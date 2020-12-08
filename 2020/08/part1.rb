class Cpu
  attr_accessor :instructions, :accumulator, :pc, :exec_history

  def initialize(instructions)
    parse_instructions(instructions)
    @accumulator = 0
    @exec_history = Hash.new { |h,k| h[k] = 0 }
    @pc = 0
  end

  def run
    while exec_history[pc] == 0 do
      self.exec_history[pc] += 1
      excecute(*instructions[pc])
    end
  end

  private

  def excecute(opcode, param)
    case opcode
    when 'acc'
      self.accumulator += param
    when 'jmp'
      self.pc += param
    end

    if opcode != 'jmp'
      self.pc += 1
    end
  end

  def parse_instructions(instr)
    @instructions = instr.map(&:strip).map(&:split).map { |code, param| [code, param.to_i] }
  end
end

cpu = Cpu.new(@data)
cpu.run
@output = cpu.accumulator

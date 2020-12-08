class Cpu
  attr_accessor :instructions, :accumulator, :pc, :exec_history, :pc_history

  def initialize(instructions)
    parse_instructions(instructions)
    reset
  end

  def reset
    @pc = 0
    @pc_history = []
    @exec_history = Hash.new { |h,k| h[k] = 0 }
    @accumulator = 0
  end

  def run(max: 1, current_instructions: instructions)
    while exec_history[pc] < max && pc < current_instructions.count do
      self.pc_history.push(pc)
      self.exec_history[pc] += 1
      excecute(*current_instructions[pc]) rescue puts pc
    end

    return pc >= current_instructions.count
  end

  def loop_commands
    @loop_commands ||= begin
      reset
      run(max: 2)
      exec_history.select { |k,v| v > 1 && instructions[k].first != 'acc' }.map(&:first)
    end
  end

  def opcode_fixer
    loop_commands.find do |pc|
      ci = instructions.dup
      ci[pc] = [(ci[pc].first == 'jmp' ? 'nop' : 'jmp' ), ci[pc].last]

      reset
      run(current_instructions: ci)
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
cpu.opcode_fixer
@output = cpu.accumulator

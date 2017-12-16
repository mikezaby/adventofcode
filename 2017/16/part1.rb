class DancingMachine
  attr_accessor :programs

  MOVES = {
    's' => :spin,
    'x' => :exchange,
    'p' => :partner
  }

  def initialize
    @programs = ('a'..'p').to_a
    @moves = File.read('2017/16/input.txt').split(',')
  end

  def dance
    @moves.each do |move|
      _, command, *values = move.match(/(\w)(\w*)(?:\/(\w*))?/).to_a

      send(MOVES[command], *values)
    end
  end

  def spin(count, _)
    programs.rotate!(-count.to_i)
  end

  def exchange(index1, index2)
    index1 = index1.to_i
    index2 = index2.to_i

    value1 = programs[index1]
    value2 = programs[index2]

    programs[index2] = value1
    programs[index1] = value2
  end

  def partner(program1, program2)
    index1 = programs.index(program1)
    index2 = programs.index(program2)

    programs[index2] = program1
    programs[index1] = program2
  end
end

dancing_maching = DancingMachine.new
dancing_maching.dance

p dancing_maching.programs.join

class DancingMachine
  attr_accessor :programs, :previous_dances

  MOVES = {
    's' => :spin,
    'x' => :exchange,
    'p' => :partner
  }

  def initialize
    @programs = ('a'..'p').to_a
    @moves = File.read('2017/16/input.txt').split(',')

    @previous_dances = [@programs.dup]
  end

  def dance
    @moves.each do |move|
      _, command, *values = move.match(/(\w)(\w*)(?:\/(\w*))?/).to_a

      send(MOVES[command], *values)
    end

    previous_dances.push(programs.dup)

    programs
  end

  def diffent_dance_count
    initial_state = ('a'..'p').to_a

    (1..1000000000).lazy.find { dance == initial_state }
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

diffent_dance_count = dancing_maching.diffent_dance_count
p dancing_maching.previous_dances[1000000000 % diffent_dance_count].join

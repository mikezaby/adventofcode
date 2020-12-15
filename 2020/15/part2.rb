spoken_numbers = [1,0,18,10,19,6]

class Number
  attr_reader :name
  attr_accessor :prev_index, :current_index

  def initialize(name)
    @name = name
  end

  def index=(index)
    self.prev_index = current_index
    self.current_index = index
  end

  def next_number
    return 0 if prev_index.nil? || current_index.nil?

    current_index - prev_index
  end
end

class Game
  attr_reader :starting_numbers
  attr_accessor :last_number

  def initialize(starting_numbers)
    @starting_numbers = starting_numbers
    initialize_game
  end

  def numbers
    @numbers ||= Hash.new { |h,k| h[k] = Number.new(k) }
  end

  def run(turns)
    ((starting_numbers.count + 1)..turns).each do |index|
      self.last_number = numbers[last_number.next_number]
      last_number.index = index
    end
  end

  private

  def initialize_game
    starting_numbers.each.with_index(1) do |num, index|
      numbers[num].index = index
    end
    self.last_number = numbers[starting_numbers.last]
  end
end

game = Game.new(spoken_numbers)
game.run(30000000)
@output = game.last_number.name

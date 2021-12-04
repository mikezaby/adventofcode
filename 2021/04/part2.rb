class Bingo
  attr_reader :data

  def initialize(data)
    @data = data
  end

  def numbers
    @numbers ||= data.first.split(",").map(&:to_i)
  end

  def boards
    @boards ||= data[2..-1]
      .reject(&:empty?)
      .map { |line| line.split(" ").map(&:to_i) }
      .each_slice(5)
      .map { |board| Board.new(board) }
  end

  def find_loser(index = 0)
    boards.each { |board| board.mark(numbers[index]) }

    finished = boards.all?(&:winner?)

    finished ? boards.max_by { |b| b.marked.count } : find_loser(index + 1)
  end
end

class Board
  attr_reader :data, :transposed_data, :flat_data, :marked

  def initialize(data)
    @data = data
    @transposed_data = data.transpose
    @flat_data = data.flatten
    @marked = []
  end

  def mark(number)
    return if winner?

    marked.push(number)
  end

  def winner?
    data.any? { |l| l.all? { |n| marked.include?(n) } } ||
      transposed_data.any? { |l| l.all? { |n| marked.include?(n) } }
  end

  def score
    (flat_data - marked).sum * marked.last
  end
end

bingo = Bingo.new(@data)
@output = bingo.find_loser.score

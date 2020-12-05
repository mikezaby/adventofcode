class BoardingPass
  attr_reader :code

  MAX_ROWS = 128
  MAX_COLUMNS = 8

  CHARS = {
    'F' => :left,
    'B' => :right,
    'L' => :left,
    'R' => :right
  }

  def initialize(code)
    @code = code
  end

  def row
    @row ||= find_number(code.chars.first(7), MAX_ROWS)
  end

  def column
    @column ||= find_number(code.chars.last(3), MAX_COLUMNS)
  end

  def seat_id
    @seat_id ||= (row * 8) + column
  end

  private

  def find_number(chars, size, index = 0)
    return index if chars.empty?

    c = chars.shift
    size = size / 2

    if CHARS[c] == :right
      index = index + size
    end

    find_number(chars, size, index)
  end
end

@output = @data.map(&:strip)
  .map { |code| BoardingPass.new(code) }
  .max_by(&:seat_id)

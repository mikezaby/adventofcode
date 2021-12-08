class FourDigit
  attr_reader :pattern, :digits

  def initialize(line)
    @pattern, @digits = line.split(" | ").map { |s| s.split.map { |d| d.chars.sort.join } }
  end

  def to_i
    digits.map { |digit| mappings.index { |n| n == digit } }.join.to_i
  end

  private

  def mappings
    @mappings ||= [zero, one, two, three, four, five, six, seven, eight, nine]
  end

  def a
    @a ||= seven.chars - one.chars
  end

  def zero
    @zero ||= (numbers_by_length(6) - [nine, six]).first
  end

  def one
    @one ||= numbers_by_length(2).first
  end

  def two
    return @two if defined?(@two)

    index = numbers_by_length(5).map { |n| n.chars - nine.chars }.index(&:one?)
    @two = numbers_by_length(5)[index]
  end

  def three
    return @three if defined?(@three)

    possible_numbers = (numbers_by_length(5) - [two])
    index = possible_numbers.map { |n| n.chars - two.chars - one.chars }.index(&:empty?)
    @three = possible_numbers[index]
  end

  def four
    @four ||= numbers_by_length(4).first
  end

  def five
    @five ||= (numbers_by_length(5) - [two, three]).first
  end

  def six
    return @six if defined?(@six)

    possible_numbers = (numbers_by_length(6) - [nine])
    index = possible_numbers.map { |n| n.chars - five.chars }.index(&:one?)
    @six = possible_numbers[index]
  end

  def seven
    @seven ||= numbers_by_length(3).first
  end

  def eight
    @eight ||= numbers_by_length(7).first
  end

  def nine
    return @nine if defined?(@nine)

    index = numbers_by_length(6).map { |num| num.chars - four.chars - a }.index(&:one?)
    @nine = numbers_by_length(6)[index]
  end

  def numbers_by_length(length)
    pattern.select { |n| n.length == length }
  end
end

@output =  @data.map { |line| FourDigit.new(line).to_i }.sum

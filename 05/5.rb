class ProperStrings
  attr_reader :file, :naughty, :nice

  def initialize(file_path)
    @file = File.new(file_path, "r")
    @naughty = []
    @nice = []
    classificate_all
  end

  private

  def classificate_all
    file.each_line do |string|
      classification(string.chomp)
    end
    file.close
  end

  def classification(string)
    nice?(string) ? nice.push(string) : naughty.push(string)
  end

  def nice?(string)
    ["xyx?", "pair?"].all? { |rule| send(rule, string) }
  end

  def xyx?(string)
    string.each_char.with_index.any? { |c, i| c == string[i+2] }
  end

  def pair?(string)
    chars = string.chars

    chars.count.times.any? do
      chars_tmp = chars.dup
      pair = chars_tmp.shift(2)
      chars.shift
      chars_tmp.join.include?(pair.join)
    end
  end
end

ps = ProperStrings.new('5.data')
puts ps.nice.count

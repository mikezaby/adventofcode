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
    puts string
    nice?(string) ? nice.push(string) : naughty.push(string)
  end

  def nice?(string)
    ["vowels?", "allowed?", "twice?"].all? { |rule| send(rule, string) }
  end

  def vowels?(string)
    rules = ['a', 'e', 'i', 'o', 'u']
    string.chars.count { |c| rules.include? c } >= 3
  end

  def allowed?(string)
    rules = %w(ab cd pq xy)
    rules.none? { |rule| string.include?(rule) }
  end

  def twice?(string)
    tmp = ''
    string.chars.any? do |c|
      prev = tmp
      tmp = c
      c == prev
    end
  end
end

ps = ProperStrings.new('5.data')
puts ps.nice.count

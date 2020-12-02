class PasswordValidator
  attr_reader :password, :letter, :range

  def initialize(input)
    @input = input
    parse
  end

  def valid?
    range.include?(password.count(letter))
  end

  private

  def parse
    policy, @password = @input.split(':').map(&:strip)
    range, @letter = policy.split(' ')
    a,b = range.split('-').map(&:to_i)
    @range = (a..b)
  end
end

@output = @data
  .map { |input| PasswordValidator.new(input) }
  .select(&:valid?)
  .count

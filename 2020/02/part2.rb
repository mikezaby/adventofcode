class PasswordValidator
  attr_reader :password, :letter, :position, :a , :b

  def initialize(input)
    @input = input
    parse
  end

  def valid?
    (password[a] == letter) ^ (password[b] == letter)
  end

  private

  def parse
    policy, @password = @input.split(':').map(&:strip)
    range, @letter = policy.split(' ')
    @a, @b = range.split('-').map(&:to_i).map { |i| i - 1 }
  end
end

@output = @data
  .map { |input| PasswordValidator.new(input) }
  .select(&:valid?)
  .count

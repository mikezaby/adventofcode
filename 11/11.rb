class PasswordGenerator
  attr_reader :password, :pass_chars

  def initialize(password)
    @password = password
  end

  def next_password
    password.succ!
    password.succ! while !valid?
    self
  end

  def to_s
    password
  end

  private

  def valid?
    [:abc?, :pair?, :allowed?].all? { |rule| send(rule) }
  end

  def allowed?
    !password.match(/[iol]/)
  end

  def abc?
    password.chars.each_cons(3).any? { |c| [c[0].succ.succ, c[1].succ, c[2]].uniq.size == 1}
  end

  def pair?
    prev = nil
    password.chars.each_cons(2).count do |c|
      next if prev == c

      prev = c
      c[0] == c[1]
    end > 1
  end
end

pg = PasswordGenerator.new('cqjxjnds')
puts pg.next_password.next_password

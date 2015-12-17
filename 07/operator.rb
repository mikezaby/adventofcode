class Operator
  MAX = 65536

  attr_reader :op, :inputs

  def initialize(op, inputs)
    @op = op.downcase
    @inputs = inputs
  end

  def value
    @value ||= send(op, *inputs.map(&:value)) % MAX
  end

  private

  def and(a, b)
    a & b
  end

  def or(a, b)
    a | b
  end

  def not(a)
    MAX + ~a
  end

  def lshift(a, b)
    a << b
  end

  def rshift(a, b)
    a >> b
  end
end

class Integer
  def value
    self
  end
end

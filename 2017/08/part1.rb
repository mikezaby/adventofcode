class CPU
  def initialize
    @instructions = File.read('2017/08/input.txt').each_line.map do |line|
      line.sub!('inc', '+=')
      line.sub!('dec', '-=')
      line.sub!("\n", '')
      "self.#{line}"
    end

    @register = Hash.new(0)
  end

  def execute
    @instructions.each { |line| eval(line) }
  end

  def max
    p @register
    @register.values.max
  end

  private

  def method_missing(method, value = 0)
    if (method.to_s.match(/=$/))
      method = method.to_s.sub('=', '').to_sym;
      @register[method] = value
    else
      @register[method]
    end
  end
end

cpu = CPU.new
cpu.execute
p cpu.max

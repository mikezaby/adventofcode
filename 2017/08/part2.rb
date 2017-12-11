class CPU
  def initialize
    @instructions = File.read('2017/08/input.txt').each_line.map do |line|
      line.sub!('inc', '+=')
      line.sub!('dec', '-=')
      line.sub!("\n", '')
      "self.#{line}"
    end

    @register = Hash.new(0)
    @max_existed_value = 0
  end

  def execute
    @instructions.each { |line| eval(line) }
  end

  def max
    @max_existed_value
  end

  private

  def method_missing(method, value = 0)
    if (method.to_s.match(/=$/))
      method = method.to_s.sub('=', '').to_sym;

      @max_existed_value = value if @max_existed_value < value

      @register[method] = value
    else
      @register[method]
    end
  end
end

cpu = CPU.new
cpu.execute
p cpu.max

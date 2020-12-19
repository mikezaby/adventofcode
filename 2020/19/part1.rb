class MessageValidator
  attr_reader :rules
  attr_accessor :messages

  def initialize(data)
    @rules = {}
    parse(data)
    @pointers = {}
  end

  def pointer(index)
    @pointers[index] ||= Pointer.new(index, rules[index], self)
  end

  private

  def parse(data)
    rule_data, msgs = data.file.read.gsub('"', "").split("\n\n")

    rule_data.scan(/(\d+):((?: \w+)+)(?: \|)?((?: \w+)+)?/).each do |i, *r|
      rules[i.to_i] = r.compact.map { |x| x.to_i.zero? ? x.strip : x.split.map(&:to_i) }
    end

    self.messages = msgs.split("\n")
  end
end

class Pointer
  attr_reader :index, :values

  def initialize(index, values, validator)
    @index = index
    @values = values.map { |v| v.kind_of?(String) ? v : v.map { |i| validator.pointer(i) } }
  end

  def strings(initial_strings = [""])
    return initial_strings.map { |str| "#{str}#{values.first}" } if type == :char

    values.map do |pointers|
      pointers.reduce(initial_strings) do |strs, pointer|
        pointer.strings(strs)
      end
    end.flatten
  end

  def type
    @type ||= if values.first.kind_of?(String)
                :char
              elsif values.count == 1
                :single
              else
                :multi
              end
  end

  def inspect
    "Pointer #{index}: type => #{type}"
  end
end

validator = MessageValidator.new(@data)

@output = (validator.pointer(0).strings & validator.messages).count


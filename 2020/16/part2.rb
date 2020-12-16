class TicketValidator
  attr_reader :data

  def initialize(data)
    @data = data.file.read.split("\n\n")
  end

  def rules
    @rules ||= data[0]
      .scan(/(\w+(?: \w+)?)\: (\d+)-(\d+) or (\d+)-(\d+)/)
      .map { |k, a,b,c,d| [k, [(a.to_i..b.to_i), (c.to_i..d.to_i)]] }
      .to_h
  end

  def all_valid_numbers
    @all_valid_numbers ||= rules.values.map { |ranges| ranges.map(&:to_a) }.flatten.uniq
  end

  def my_ticket
    @my_ticket ||= data[1].lines[1].split(",").map(&:to_i)
  end

  def columns
    @columns ||= data[2]
      .lines[1..-1]
      .map { |line| line.split(",").map(&:to_i) }
      .reject { |t| (t - all_valid_numbers).any? }
      .transpose
  end

  def matched_columns(matches = posible_matched_columns)
    return matches.map { |i,v| [i, v.first] }.to_h if matches.all? { |_, values| values.one? }

    one_matched_names = matches.select { |_, names| names.one? }.map(&:last).flatten

    matched_columns(
      matches.map { |i, names| names.many? ? [i, names - one_matched_names] : [i, names] }
    )
  end

  private

  def posible_matched_columns
    columns.each_with_index.map do |column, index|
      rule_names = rules
        .select { |_, (rule1, rule2)| column.all? { |v| rule1.include?(v) || rule2.include?(v) } }

      [index, rule_names.map(&:first)]
    end
  end
end

validator = TicketValidator.new(@data)
@output = validator.matched_columns
  .select { |i, name| name.match?("departure") }
  .map(&:first)
  .reduce(1) { |result, index| result *= validator.my_ticket[index] }

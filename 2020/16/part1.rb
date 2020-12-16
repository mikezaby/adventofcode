class TicketValidator
  attr_accessor :numbers, :tickets

  def initialize(data)
    parse(data)
  end

  def error_rate
    tickets.map { |ticket| ticket - numbers }.flatten.sum
  end

  private

  def parse(data)
    nums, _, tickets = data.file.read.split("\n\n")

    self.numbers = nums.scan(/((\d+)-(\d+))/).map { |_, a,b| (a.to_i..b.to_i).to_a }.flatten
    self.tickets = tickets.lines[1..-1].map { |line| line.split(",").map(&:to_i) }
  end
end

validator = TicketValidator.new(@data)
@output =  validator.error_rate

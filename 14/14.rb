require '../file_helper.rb'

class Reindeer
  attr_reader :name, :kms, :duration, :rest

  def initialize(name, kms, duration, rest)
    @name = name
    @kms = kms.to_i
    @duration = duration.to_i
    @rest = rest.to_i
  end

  def distance(seconds)
    rounds, remaining = seconds.divmod(duration+rest)
    extra_km = [remaining, duration].min * kms
    rounds * duration * kms + extra_km
  end
end

distances = FileHelper.new('14.data').map do |line|
  tokens = line.split
  Reindeer.new(tokens[0], tokens[3], tokens[6], tokens[13]).distance(2503)
end

puts distances.max

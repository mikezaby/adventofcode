require '../file_helper.rb'

class Reindeer
  attr_reader :name, :kms, :duration, :rest
  attr_accessor :points, :last_distance

  def initialize(name, kms, duration, rest)
    @name = name
    @kms = kms.to_i
    @duration = duration.to_i
    @rest = rest.to_i
    @points = 0
    @last_distance
  end

  def distance(seconds)
    rounds, remaining = seconds.divmod(duration+rest)
    extra_km = [remaining, duration].min * kms
    self.last_distance = rounds * duration * kms + extra_km
  end

  def get_point
    self.points += 1
  end
end

reindeers = FileHelper.new('14.data').map do |line|
  tokens = line.split
  Reindeer.new(tokens[0], tokens[3], tokens[6], tokens[13])
end

(1..2503).each do |seconds|
  grouped = reindeers.group_by { |r| r.distance(seconds) }.sort.last.last.each(&:get_point)
end

puts reindeers.group_by(&:points).sort.last.last.max_by(&:last_distance).points

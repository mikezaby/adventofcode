class SantaDeliver
  attr_reader :houses, :route
  attr_accessor :santa, :robot

  def initialize(file_path)
    @route = File.new(file_path, "r").gets.chomp
    @houses = Hash.new(0)
    @robot = @santa = [0,0]
    deliver('santa')
  end

  def deliver_all
    route.each_char.with_index do |direction, index|
      who = index.odd? ?  'santa' : "robot"
      move(who, direction)
      deliver(who)
    end
  end

  def delivered_houses
    houses.keys.count
  end

  def deliver(who)
    houses[send(who)] += 1
  end

  def move(who, direction)
    point = send(who)
    new_point = case direction
    when '>'
      [point.first+1, point.last]
    when '<'
      [point.first-1, point.last]
    when '^'
      [point.first, point.last+1]
    when 'v'
      [point.first, point.last-1]
    end

    send("#{who}=", new_point)
  end
end

santa_deliver = SantaDeliver.new("3.data")
santa_deliver.deliver_all
p santa_deliver.houses
puts santa_deliver.delivered_houses

class SantaDeliver
  attr_reader :houses, :route
  attr_accessor :point

  def initialize(file_path)
    @route = File.new(file_path, "r").gets.chomp
    @houses = Hash.new(0)
    @point = [0,0]
    @houses[@point] += 1
  end

  def deliver_all
    route.each_char do |direction|
      move(direction)
      deliver
    end
  end

  def delivered_houses
    houses.keys.count
  end

  def deliver
    houses[point] += 1
  end

  def move(direction)
    self.point = case direction
    when '>'
      [point.first+1, point.last]
    when '<'
      [point.first-1, point.last]
    when '^'
      [point.first, point.last+1]
    when 'v'
      [point.first, point.last-1]
    end
  end
end

santa_deliver = SantaDeliver.new("3.data")
santa_deliver.deliver_all
p santa_deliver.houses
puts santa_deliver.delivered_houses

class Tower
  attr_reader :name, :level, :children

  attr_accessor :weight

  def initialize(name)
    @name = name
    @level = 0
    @children = []
  end

  def children=(values)
    child_level = level + 1

    values.each do |child|
      child.level = child_level
    end
  end

  def root?
    level == 0
  end

  protected

  def level=(value)
    new_level = [@level, value].max

    if (new_level != @level)
      @level = new_level

      children.each do |child|
        child.level = value
      end
    end

    @level
  end
end

class TowerManager
  def initialize
    @towers = {}

    read_programs
  end

  def tower(name)
    @towers[name] ||= Tower.new(name)
  end

  def root
    @towers.find { |_, tower| tower.root? }
  end

  def read_programs
    File.read('2017/07/input.txt').each_line do |program|
      name, weight, *children = program.scan(/\w+/)

      tower(name).children = children.map { |child| tower(child) }
      tower(name).weight = weight
    end
  end
end

manager = TowerManager.new()
puts manager.root

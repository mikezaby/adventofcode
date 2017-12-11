class Tower
  attr_reader :name, :level, :children

  attr_accessor :weight, :parent

  def initialize(name)
    @name = name
    @level = 0
    @children = []
  end

  def children=(values)
    child_level = level + 1

    values.each do |child|
      child.level = child_level
      child.parent = self
    end

    @children.push(*values)
  end

  def total_weight
    @total_weight ||= weight + (children.reduce(0) { |sum, child| sum + child.total_weight } || 0)
  end

  def root?
    level == 0
  end

  def unbalanced
    is_balanced = children.map(&:total_weight).uniq.count <= 1

    if is_balanced
      return self
    end

    unbalanced_tower = children.group_by { |child| child.total_weight }.
      sort_by { |group| - group.last.count }.last.last.first

    unbalanced_tower.unbalanced
  end

  def proper_weight
    (balanced_weight, _), (unbalanced_weight, _) = parent.children.map(&:total_weight).group_by { |w| w }.sort
    weight - (unbalanced_weight - balanced_weight)
  end

  protected

  def inspect
    "<Tower name: #{name}, weight: #{weight}, total_weight: #{total_weight}>"
  end

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
    @towers.find { |_, tower| tower.root? }.last
  end

  def read_programs
    File.read('2017/07/input.txt').each_line do |program|
      name, weight, *children = program.scan(/\w+/)

      tower(name).children = children.map { |child| tower(child) }
      tower(name).weight = weight.to_i
    end
  end
end

manager = TowerManager.new()

puts manager.root.unbalanced.proper_weight

class Node
  attr_accessor :name, :parent

  def initialize(name)
    @name = name
  end

  def children
    @children ||= []
  end

  def add_node(node)
    node.parent = self
    children.push(node)
  end

  def parents
    @parents ||= root? ? [] : [parent, *parent.parents]
  end

  def root?
    parent.nil?
  end

  def inspect
    "#{self.class.name}: #{name}"
  end
end

class Universe
  attr_reader :nodes

  def initialize(data)
    @nodes = Hash.new { |h, k| h[k] = Node.new(k) }
    read_map(data)
  end

  private

  def read_map(data)
    data.map(&:strip).each do |line|
      parent, child = line.split(')')

      @nodes[parent].add_node(@nodes[child])
    end
  end
end

universe = Universe.new(@data)
@output = ((universe.nodes["YOU"].parents -  universe.nodes["SAN"].parents) + (universe.nodes["SAN"].parents -  universe.nodes["YOU"].parents)).count

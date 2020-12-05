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

  def root?
    parent.nil?
  end

  def count_connections
    @count_connections ||= begin
      count = 0
      node = self

      while !node.root?
        count += 1
        node = node.parent
      end

      count
    end
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

  def root
    @root ||= @nodes.values.find(&:root?)
  end

  def count_connections
    nodes.values.sum(&:count_connections)
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
@output =  universe.count_connections

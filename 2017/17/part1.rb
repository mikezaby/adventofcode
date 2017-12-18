class Node
  def self.find(value)
    all_nodes[value]
  end

  attr_accessor :name
  attr_writer :left, :right

  def initialize(name)
    @name = name
  end

  def left
    @left ||= self.class.find(0)
  end

  def right(times = 1)
    @right ||= self.class.find(0)

    times == 1 ? @right : @right.right(times - 1)
  end

  private

  def self.all_nodes
    @all_nodes ||= Hash.new { |h,k| h[k] = Node.new(k) }
  end
end

node = Node.find(0)
steps = 345

(1..2017).each do |i|
  new_node = Node.find(i)

  node = node.right(steps)

  new_node.left = node
  new_node.right = node.right
  node.right.left = new_node
  node.right = new_node

  node = new_node
end

p Node.find(2017).right.name

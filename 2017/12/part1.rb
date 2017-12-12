require 'set'

class Node
  attr_reader :id
  attr_accessor :connections

  def self.create_nodes
    all_nodes = Hash.new { |h,k| h[k] = Node.new(k) }

    File.read('2017/12/input.txt').each_line do |line|
      id, *connections = line.gsub(/(<-> |,)/, '').split(' ').map(&:to_i)

      node = all_nodes[id]
      node.add(*connections.map { |connection| all_nodes[connection] })
    end

    all_nodes
  end

  def initialize(id)
    @id = id
    @connections = Set.new([self])
  end

  def add(*nodes)
    nodes.each do |node|
      connections.add node

      node.connections.add self
    end
  end

  def network(all = Set.new)
    new = connections - all
    all = all + new

    return all if new.empty?

    new.reduce(all) { |memo, node| node.network(memo) }
  end
end

p Node.create_nodes[0].network.count

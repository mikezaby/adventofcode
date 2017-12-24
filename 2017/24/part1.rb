require 'set'

class Component
  attr_reader :id, :name, :connection

  def initialize(id, name, connection)
    @id = id
    @name = name
    @connection = connection
  end

  def to_s
    "#{name}/#{connection}"
  end

  def sum
    @sum ||= name + connection
  end
end

class Bridge
  attr_accessor :bridge, :component_ids, :current

  def initialize(comp)
    @bridge = [comp]
    @component_ids = Set.new([comp.id])
    @current = comp
  end

  def clone
    new_bridge = dup
    new_bridge.bridge = bridge.dup
    new_bridge.component_ids = component_ids.dup
    new_bridge
  end

  def sum
    bridge.reduce(0) { |sum, comp| sum + comp.sum }
  end

  def add(comp)
    return nil if component_ids.include?(comp.id)

    new_bridge = clone
    new_bridge.component_ids.add(comp.id)
    new_bridge.bridge.push(comp)
    new_bridge.current = comp
    new_bridge
  end
end

class BridgeGenerator
  attr_reader :components, :completed_bridges
  attr_accessor :bridges

  def initialize(components)
    @components = components
    @bridges = components[0].map { |comp| Bridge.new(comp) }
    @completed_bridges = Set.new
  end

  def generate
    current_bridges = bridges
    self.bridges = []

    current_bridges.each do |bridge|
      new_comps = components[bridge.current.connection]

      new_comps.each do |comp|
        if (new_bridge = bridge.add(comp))
          bridges.push(new_bridge)
        else
          completed_bridges.add(bridge)
        end
      end
    end

    bridges.empty? ? nil : generate
  end
end

components = File.read('2017/24/input.txt').each_line.map { |c| c.split('/').map(&:to_i) }

components = components.reduce(Hash.new { |h,k| h[k] = [] }) do |hash, comp|
  hash[comp.first].push(Component.new(comp.object_id, comp.first, comp.last))

  if (comp.last != comp.first)
    hash[comp.last].push(Component.new(comp.object_id, comp.last, comp.first))
  end

  hash
end

generator = BridgeGenerator.new(components)
generator.generate
p generator.completed_bridges.map(&:sum).max

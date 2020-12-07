class Bag
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def children
    @children ||= []
  end

  def parents
    @parents ||= []
  end

  def all_parents
    @all_perents ||= (parents + parents.map(&:all_parents).flatten).uniq
  end

  def add_child(child)
    child.parents.push(self)
    children.push(child)
  end

  def inspect
    "#{self.class.name}: #{name}"
  end
end

class RuleReader
  attr_reader :bags

  def initialize(data)
    @bags = Hash.new { |h, k| h[k] = Bag.new(k) }
    read_rules(data)
  end

  private

  def read_rules(data)
    data.map(&:strip).each do |line|
      rule = line.split

      name = rule[0..1].join(' ')
      bags[name]

      parse_children(rule[4..-1]).each do |cname, count|
        bags[name].add_child(bags[cname])
      end
    end
  end

  def parse_children(rule)
    return [] if !rule[0].match?(/\d+/)

    rule.join(' ').split(', ').map do |r|
      r = r.split
      [r[1..2].join(' '), r[0].to_i]
    end
  end
end

rules =  RuleReader.new(@data)
@output = rules.bags['shiny gold'].all_parents.count

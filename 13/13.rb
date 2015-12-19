require '../file_helper.rb'

class TableHappiness
  attr_reader :file, :karmas

  def initialize(file_path)
    @file = FileHelper.new(file_path)
    @karmas = {}
  end

  def fetch_karma
    file.each { |line| karma(line.chomp[0...-1]) }
  end

  def persons
    karmas.keys.flatten.uniq
  end

  def best_seats
    all_combinations.map { |p| p.reduce(0) { |sum, comb| sum + karmas[comb.sort] } }.max
  end

  def all_combinations
    permutations = []

    persons.permutation do |p|
      if p[0] < p[-1]
        p = p.each_cons(2).map(&:sort)
        p.push [p.first[0], p.last[1]].sort
        permutations.push p
      end
    end

    permutations
  end

  private

  def karma(string)
    person1, _, sign, points, _, _, _, _, _, _, person2 = string.split
    comb = [person1, person2].sort
    sign = sign == 'gain' ? '+' : '-'

    karmas[comb] = karmas[comb].to_i + eval("#{sign}#{points}")
  end
end

table = TableHappiness.new("13.data")
table.fetch_karma
puts table.best_seats

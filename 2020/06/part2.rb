class Answer
  attr_accessor :ppl

  def initialize
    @ppl = 0
  end

  def answers
    @answers ||= []
  end

  def same_answer_count
    answers.group_by(&:itself).values.count { |v| v.count == ppl }
  end
end

@output = @data.reduce([Answer.new]) do |group, value|
  if value.blank?
    group.push(Answer.new)
    next group
  end

  group.last.answers.push(*value.strip.chars)
  group.last.ppl += 1

  group
end.sum(&:same_answer_count)

def parse(expr, arr = [])
  char = expr.shift

  return arr if char == ")" || char.nil?

  if char == "("
    arr.push(parse(expr))
  else
    num = char.to_i
    arr.push(num.zero? ? char : num)
  end

  parse(expr, arr)
end

def calculate(expr, num = 0, sym = "+")
  element = expr.shift

  return num if element.nil?

  if element.kind_of?(String)
    sym = element
  else
    value = element.kind_of?(Array) ? calculate(element) : element
    num = num.send(sym, value)
  end

  calculate(expr, num, sym)
end

@output = @data.file.read.gsub(" ", "").split("\n").sum do |expr|
  calculate(parse(expr.chars))
end

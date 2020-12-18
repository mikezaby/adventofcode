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

def calculate(expr, new_expr = [0], sym = "+")
  element = expr.shift

  return new_expr.reduce(:*) if element.nil?

  if element.kind_of?(String)
    sym = element
  else
    value = element.kind_of?(Array) ? calculate(element) : element

    if sym == "*"
      new_expr.push(value)
    else
      new_expr[-1] += value
    end
  end

  calculate(expr, new_expr, sym)
end

@output = @data.file.read.gsub(" ", "").split("\n").sum do |expr|
  calculate(parse(expr.chars))
end

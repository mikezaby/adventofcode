my_square = 312051

width = Math.sqrt(my_square).ceil
width += 1 if width.even?

radius = (width - 1) / 2

last_square = width ** 2

(((last_square - my_square) % width) - radius).abs + radius

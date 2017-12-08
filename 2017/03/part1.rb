my_square = 312051

width = Math.sqrt(my_square).ceil
width += 1 if width.even?

radius = width / 2

last_square = width ** 2

sides_behind = (last_square - my_square) / (width - 1)
last_side_square = last_square - sides_behind * (width - 1)

((last_side_square - my_square) - radius).abs + radius

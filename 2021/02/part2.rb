def execute(command, point)
  cmd, value = command.split
  value = value.to_i

  case cmd
  when "forward"
    point[:x] += value
    point[:y] += value * point[:aim]
  when "down"
    point[:aim] += value
  when "up"
    point[:aim] -= value
  else
    raise :uknown_command
  end

  point
end

def drive(commands, point = { aim: 0, x: 0, y: 0 })
  return point if commands.empty?

  command = commands.shift
  drive(commands, execute(command, point))
end

final_point = drive(@data)
@output = final_point[:x] * final_point[:y]

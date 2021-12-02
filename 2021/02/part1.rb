def execute(command)
  cmd, value = command.split
  value = value.to_i

  case cmd
  when "forward"
    Vector[value, 0]
  when "down"
    Vector[0, value]
  when "up"
    Vector[0, -value]
  else
    raise :uknown_command
  end
end

def drive(commands, point = Vector[0,0])
  return point if commands.empty?

  command = commands.shift
  drive(commands, execute(command) + point)
end

@output = drive(@data).reduce(:*)

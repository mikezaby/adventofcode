instructions = File.read('2017/05/input.txt').each_line.map(&:to_i)

instructions_count = instructions.count

offset = 0
step = 0

loop do
  new_offset = offset + instructions[offset]
  step += 1

  break puts(step) if new_offset >= instructions_count || new_offset < 0

  instructions[offset] += 1
  offset = new_offset
end

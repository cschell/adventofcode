codes = File.read("input.txt").split(",").map(&:to_i)

codes[1] = 12
codes[2] = 2

instruction_pointer = 0

loop do
  instruction,
  parameter_1_idx,
  parameter_2_idx,
  target_idx = codes[instruction_pointer..(instruction_pointer + 3)]


  case instruction
  when 1
    codes[target_idx] = codes[parameter_1_idx] + codes[parameter_2_idx]
  when 2
    codes[target_idx] = codes[parameter_1_idx] * codes[parameter_2_idx]
  when 99
    break
  else
    puts "encountered invalid value: #{instruction}"
    break
  end

  instruction_pointer += 4
end

puts(codes[0])

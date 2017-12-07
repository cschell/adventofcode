require "pp"
input = File.read("input.txt")

instructions = input.each_line.map(&:to_i).compact

current_register = 0
jumps = 0

loop do
  instruction = instructions[current_register]

  if instruction.nil?
    puts jumps
    break
  end

  if instruction >= 3
    instructions[current_register] -= 1
  else
    instructions[current_register] += 1
  end

  current_register += instruction
  jumps += 1
end

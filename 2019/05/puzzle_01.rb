codes = File.read("input.txt").split(",").map(&:to_i)

instruction_pointer = 0

intcode_computer_input = 1

POSITION_MODE = "0"
IMMEDIATE_MODE = "1"

loop do
  instruction = codes[instruction_pointer].to_s.rjust(5, "0")
  opcode = instruction[-2..-1].to_i
  parameter_3_mode,
  parameter_2_mode,
  parameter_1_mode = instruction[0..2].split("")

  case opcode
  when 1, 2
    parameter_1_idx,
    parameter_2_idx,
    target_idx = codes[(instruction_pointer+1)..(instruction_pointer + 3)]

    if parameter_1_mode == POSITION_MODE
      paremter_1 = codes[parameter_1_idx]
    else
      paremter_1 = parameter_1_idx
    end

    if parameter_2_mode == POSITION_MODE
      paremter_2 = codes[parameter_2_idx]
    else
      paremter_2 = parameter_2_idx
    end

    instruction_pointer += 4

    if opcode == 1
      codes[target_idx] = paremter_1 + paremter_2
    elsif opcode == 2
      codes[target_idx] = paremter_1 * paremter_2
    else
      raise
    end
  when 3
    target_idx = codes[instruction_pointer + 1]
    codes[target_idx] = intcode_computer_input
    instruction_pointer += 2
  when 4
    target_idx = codes[instruction_pointer + 1]
    print(codes[target_idx])
    instruction_pointer += 2
  when 99
    break
  else
    puts "encountered invalid value: #{instruction}"
    break
  end
end

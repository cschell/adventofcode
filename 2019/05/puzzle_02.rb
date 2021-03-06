POSITION_MODE = "0"
IMMEDIATE_MODE = "1"

def run_intcode(codes, intcode_computer_input)
  instruction_pointer = 0
  output = []
  loop do
    instruction = codes[instruction_pointer].to_s.rjust(5, "0")
    opcode = instruction[-2..-1].to_i
    parameter_modes = instruction[0..2].split("").reverse()

    parameters = codes[(instruction_pointer+1)..(instruction_pointer + 3)].zip(parameter_modes).map do |param, mode|
      if mode == POSITION_MODE
        codes[param]
      elsif mode == IMMEDIATE_MODE
        param
      else
        raise "unkown mode"
      end
    end

    case opcode
    when 1
      target_idx = codes[instruction_pointer + 3]
      codes[target_idx] = parameters[0] + parameters[1]
      instruction_pointer += 4
    when 2
      target_idx = codes[instruction_pointer + 3]
      codes[target_idx] = parameters[0] * parameters[1]
      instruction_pointer += 4
    when 3
      target_idx = codes[instruction_pointer + 1]
      codes[target_idx] = intcode_computer_input
      instruction_pointer += 2
    when 4
      target_idx = codes[instruction_pointer + 1]
      # print codes[target_idx]
      output << codes[target_idx]
      instruction_pointer += 2
    when 5
      if parameters[0] != 0
        instruction_pointer = parameters[1] # codes[instruction_pointer + 2]
      else
        instruction_pointer += 3
      end
    when 6
      if parameters[0] == 0
        instruction_pointer = parameters[1] # codes[instruction_pointer + 2]
      else
        instruction_pointer += 3
      end
    when 7
      target_idx = codes[instruction_pointer + 3]
      if parameters[0] < parameters[1]
        codes[target_idx] = 1
      else
        codes[target_idx] = 0
      end
      instruction_pointer += 4
    when 8
      target_idx = codes[instruction_pointer + 3]
      if parameters[0] == parameters[1]
        codes[target_idx] = 1
      else
        codes[target_idx] = 0
      end
      instruction_pointer += 4
    when 99
      break
    else
      break
    end
  end

  return output.join()
end

codes = File.read("input.txt").split(",").map(&:to_i)
intcode_computer_input = 5

puts run_intcode(codes, intcode_computer_input)

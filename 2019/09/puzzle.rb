POSITION_MODE = "0"
IMMEDIATE_MODE = "1"
RELATIVE_MODE = "2"

def run_intcode(codes, signals, instruction_pointer=0)
  inputs = signals

  output = []

  memory = Hash[codes.each_with_index.map {|c, idx| [idx, c]}]
  memory.default = 0

  relative_base = 0
  loop do
    instruction = memory[instruction_pointer].to_s.rjust(5, "0")
    opcode = instruction[-2..-1].to_i
    parameter_modes = instruction[0..2].split("").reverse()

    parameter_idxs = ((instruction_pointer+1)..(instruction_pointer + 3)).to_a

    parameters = parameter_idxs.map {|idx| memory[idx] }.zip(parameter_modes).map do |param, mode|
      if mode == POSITION_MODE
        memory[param]
      elsif mode == IMMEDIATE_MODE
        param
      elsif mode == RELATIVE_MODE
        memory[relative_base + param]
      else
        raise "unkown mode"
      end
    end

    destinations = parameter_idxs.map {|idx| memory[idx] }.zip(parameter_modes).map do |param, mode|
      if mode == POSITION_MODE
        param
      elsif mode == RELATIVE_MODE
        relative_base + param
      else
        :unkown_mode
      end
    end

    case opcode
    when 1
      target_idx = destinations[2]
      memory[target_idx] = parameters[0] + parameters[1]
      instruction_pointer += 4
    when 2
      target_idx = destinations[2]
      memory[target_idx] = parameters[0] * parameters[1]
      instruction_pointer += 4
    when 3
      target_idx = destinations[0]
      memory[target_idx] = inputs.shift()
      instruction_pointer += 2
    when 4
      instruction_pointer += 2
      output << parameters[0]
    when 5
      if parameters[0] != 0
        instruction_pointer = parameters[1]
      else
        instruction_pointer += 3
      end
    when 6
      if parameters[0] == 0
        instruction_pointer = parameters[1]
      else
        instruction_pointer += 3
      end
    when 7
      target_idx = destinations[2]
      if parameters[0] < parameters[1]
        memory[target_idx] = 1
      else
        memory[target_idx] = 0
      end
      instruction_pointer += 4
    when 8
      target_idx = destinations[2]
      if parameters[0] == parameters[1]
        memory[target_idx] = 1
      else
        memory[target_idx] = 0
      end
      instruction_pointer += 4
    when 9
      relative_base += parameters[0]
      instruction_pointer += 2
    when 99
      break
    else
      raise "error, don't know code #{opcode}"
    end
  end

  return output.join(",")
end

codes = File.read("input.txt").split(",").map(&:to_i)

puts "puzzle 01"
result_1 = run_intcode(codes, [1])
puts result_1

puts "puzzle 02"
result_2 = run_intcode(codes, [2])
puts result_2

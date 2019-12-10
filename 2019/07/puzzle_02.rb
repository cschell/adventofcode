POSITION_MODE = "0"
IMMEDIATE_MODE = "1"

def run_intcode(codes, signals, instruction_pointer=0)
  inputs = signals

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
      codes[target_idx] = inputs.shift()
      instruction_pointer += 2
    when 4
      target_idx = codes[instruction_pointer + 1]
      # print codes[target_idx]
      # output << codes[target_idx]
      instruction_pointer += 2
      return [codes[target_idx], [codes, instruction_pointer]]
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

  return [nil, [codes, instruction_pointer]]
end

codes = File.read("input.txt").split(",").map(&:to_i)

sequences = (5..9).to_a.permutation
foo = false
results = sequences.map do |sequence|
  input_signal = 0
  output_signal = 0
  stop = false
  states = {}
  first_time = true
  loop do
    sequence.each do |phase_setting|
      signals = if first_time
                  [phase_setting, input_signal]
                else
                  [input_signal]
                end
      current_codes, instruction_pointer = states.fetch(phase_setting) { [codes.dup, 0] }

      result, (new_codes, instruction_pointer) = run_intcode(current_codes, signals, instruction_pointer)
      if result.nil?
        stop = true
        break
      end
      states[phase_setting] = [new_codes, instruction_pointer]
      output_signal = result
      input_signal = output_signal

    end
    break if stop
    first_time = false
  end
  foo = true
  [sequence, output_signal]
end

puts results.max { |a, b| a[1] <=> b[1] }[1]

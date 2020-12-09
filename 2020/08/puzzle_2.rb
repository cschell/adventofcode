instructions = File.readlines("input.txt")



change_idx = 0
solution_found = false
accumulator = 0
loop do

  accumulator = 0
  visited_indices = []
  current_index = 0

  current_nop_acc_counter = 0

  loop do
    break if visited_indices.include?(current_index)
    visited_indices << current_index

    cmd, value = /(\w+) ([+-]\d+)/.match(instructions[current_index])[1..2]
    value = value.to_i

    if cmd == "jmp" || cmd == "nop"
      if current_nop_acc_counter == change_idx
        cmd = cmd == "jmp" ? "nop" : "jmp"
      end

      current_nop_acc_counter += 1
    end

    case cmd
    when "acc"
      accumulator += value
      current_index += 1
    when "jmp"
      current_index += value
    else
      current_index += 1
    end

    if current_index >= instructions.length - 1
      solution_found = true
      break
    end
  end

  break if solution_found

  change_idx += 1
end

puts accumulator
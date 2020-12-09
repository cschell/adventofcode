instructions = File.readlines("input.txt")


accumulator = 0
visited_indices = []
current_index = 0


loop do
  break if visited_indices.include?(current_index)
  visited_indices << current_index

  cmd, value = /(\w+) ([+-]\d+)/.match(instructions[current_index])[1..2]
  value = value.to_i

  case cmd
  when "acc"
    accumulator += value
    current_index += 1
  when "jmp"
    current_index += value
  else
    current_index += 1
  end
end


puts accumulator
input = File.read("input.txt")

memory_states = [input.split(" ").compact.map(&:to_i)]

while memory_states.uniq.length == memory_states.length
  current_state = memory_states[-1].dup

  target_blocks = current_state.max
  target_bank = current_state.index(target_blocks)

  current_state[target_bank] = 0

  target_blocks.times do |i|
    current_bank = target_bank + 1 + i

    if current_bank >= current_state.length
      current_bank -= current_state.length
    end

    current_state[current_bank] += 1
  end

  memory_states += [current_state]
end

puts memory_states.count - 1

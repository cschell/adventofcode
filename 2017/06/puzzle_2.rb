input = File.read("input.txt")

memory_states = [input.split(" ").compact.map(&:to_i)]

target_state = nil

target_cycles = 0

last_state = memory_states[0]

loop do
  current_state = last_state.dup

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

  last_state = current_state
  memory_states += [current_state] unless target_state

  if target_state
    target_cycles += 1
  end

  if target_state == current_state
    break
  end

  if memory_states.uniq.length != memory_states.length && target_state.nil?
    target_state = current_state
    puts "found first duplicated state"
  end
end

puts target_cycles

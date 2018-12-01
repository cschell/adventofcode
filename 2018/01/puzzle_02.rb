frequency_changes = File.readlines("./input.txt").map(&:to_i)

frequency = 0

allready_seen_frequencies = [frequency]

loop do
  f_change = frequency_changes.first

  frequency += f_change

  if allready_seen_frequencies.include?(frequency)
    break
  end

  allready_seen_frequencies.push(frequency)
  frequency_changes.rotate!
end

puts frequency

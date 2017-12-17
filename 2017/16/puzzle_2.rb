input = File.read("input.txt")

instructions = input.split(",").compact

sequence = ("a".."p").to_a

ITERATIONS = 1_000_000_000

cached_outcomes = []

operations = instructions.map do |instruction|
  case instruction
  when /s(\d+)/
    cut_off_size = $1.to_i
    proc do |seq|
      cut_off = seq.pop(cut_off_size)
      seq.unshift(*cut_off)
    end
  when /x(\d+)\/(\d+)/
    a, b = $1.to_i, $2.to_i
    proc do |seq|
      seq[a], seq[b] = [seq[b], seq[a]]
    end
  when /p(\w+)\/(\w+)/
    foo, bar = $1, $2

    proc do |seq|
      index_a = seq.index(foo)
      index_b = seq.index(bar)

      seq[index_a] = bar
      seq[index_b] = foo
    end
  end
end

sequence_repetition_size = 0

ITERATIONS.times do |i|
  cached_outcomes += [sequence.join]
  operations.each do |op|
    op.call(sequence)
  end

  puts "#{i + 1}: #{sequence.join}"

  if cached_outcomes.include?(sequence.join)
    sequence_repetition_size = i + 1
    puts "found starting sequence again after #{i + 1} iterations: #{sequence.join}"
    break
  end
end

remaining_iterations = (ITERATIONS % sequence_repetition_size)

puts "#{remaining_iterations}"

remaining_iterations.times do |i|
  operations.each do |op|
    op.call(sequence)
  end
end

puts sequence.join

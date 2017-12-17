input = File.read("input.txt")

instructions = input.split(",")

sequence = ("a".."p").to_a

instructions.each do |instruction|
  case instruction
  when /s(\d+)/
    cut_off = sequence.pop($1.to_i)
    sequence.unshift(*cut_off)
  when /x(\d+)\/(\d+)/
    sequence[$1.to_i], sequence[$2.to_i] = [sequence[$2.to_i], sequence[$1.to_i]]
  when /p(\w+)\/(\w+)/
    index_a = sequence.index($1)
    index_b = sequence.index($2)

    sequence[index_a] = $2
    sequence[index_b] = $1
  end
end


puts sequence.join

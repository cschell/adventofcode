require "matrix"

accelerations = File.read("input.txt").scan(/a=<(.+),(.+),(.+)>/)

result = accelerations.each_with_index.map do |instruction, id|
  acceleration = Vector[*instruction.map(&:to_i)]
  [id, acceleration.magnitude]
end.min { |p_a, p_b| p_a[1] <=> p_b[1] }[0]

puts result

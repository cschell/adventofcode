result = File.readlines("./input.txt").map(&:to_i).inject(:+)
puts result

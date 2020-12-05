require_relative "puzzle_1"

result = (@seat_ids.min..@seat_ids.max).to_a - @seat_ids.sort

puts "puzzle_2 result: #{result.first}"

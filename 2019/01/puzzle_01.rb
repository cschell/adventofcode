input = File.readlines("input.txt")

total_fuel = input.map {|mass| (mass.to_i / 3).floor() - 2 }.inject(:+)

puts(total_fuel)

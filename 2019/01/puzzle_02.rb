input = File.readlines("input.txt")

def calc_fuel(mass)
  required_fuel = (mass.to_i / 3).floor() - 2

  if required_fuel > 0
    return required_fuel + calc_fuel(required_fuel)
  else
    return 0
  end
end

total_fuel = input.map {|mass| calc_fuel(mass)}.inject(:+)

puts(total_fuel)

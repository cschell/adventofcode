input = File.read("input.txt")

instructions = input.scan(/(\w+) (\w+) (-?\d+) if (\w+) ([^\s]+) (-?\d+)/)

register = Hash.new(0)

operations = {
  "dec" => -1,
  "inc" => 1
}

max_value = 0

instructions.each do |instruction|
  variable, operation, value, cond_variable, cond, cond_value = instruction

  if register[cond_variable].send(cond, cond_value.to_i)
    register[variable] += value.to_i * operations[operation]
    max_value = [register[variable], max_value].max
  end
end

puts max_value

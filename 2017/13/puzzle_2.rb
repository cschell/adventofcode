input = File.read("input.txt")

instructions = input.scan(/(\d+): (\d+)/)

layers = {}

class Layer < Struct.new(:range)
  def scanner_position_at(step)
    max_index = range - 1
    max_index - (max_index - (step % (max_index * 2))).abs
  end

  def scanner_at?(step)
    scanner_position_at(step) == 0
  end
end

def getting_caught_with_delay?(delay, layers)
  package_position = -1
  layer_count = layers.keys.max + 1

  (0...layer_count).each do |step|
    package_position += 1

    if layers[package_position]&.scanner_at?(delay + step)
      return true
    end
  end

  false
end

instructions.each do |key, value|
  layers[key.to_i] = Layer.new(value.to_i)
end

delay = 0
while getting_caught_with_delay?(delay, layers) do
  delay += 1
end

puts delay

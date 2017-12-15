input = File.read("input.txt")

instructions = input.scan(/(\d+): (\d+)/)

layers = {}

class Layer < Struct.new(:range)
  def initialize(*args)
    super(*args)

    @slots = Array.new(range, :empty)
    @slots[0] = :scanner
  end

  def scanner_direction
    @_scanner_direction ||= 1
  end

  def reverse_scanner_direction
    @_scanner_direction *= -1
  end

  def scanner_position
    @slots.index(:scanner)
  end

  def step!
    next_scanner_position = scanner_position + 1 * scanner_direction

    unless (1...(range - 1)).include?(next_scanner_position)
      reverse_scanner_direction
    end

    new_slots = Array.new(range, :empty)
    new_slots[next_scanner_position] = :scanner
    @slots = new_slots
  end

  def scanner?
    scanner_position == 0
  end

  def to_s
    dict = {empty: ".", scanner: "S"}

    @slots.map {|s| dict[s] }.join("")
  end
end

instructions.each do |key, value|
  layers[key.to_i] = Layer.new(value.to_i)
end

layer_count = layers.keys.max

package_position = -1

severity = 0
layer_count.times do |i|
  package_position += 1

  if layers[package_position]&.scanner?
    severity += package_position * layers[package_position].range
  end

  puts "%s: %s" % [i, layers.values[0].to_s]
  layers.values.each(&:step!)
end

puts severity

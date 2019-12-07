inputs = File.readlines("input.txt")

wire_1, wire_2 = inputs.map{ |wire| wire.split(",").map {|inst| [inst[0], inst[1..-1].to_i]} }


class Square
  attr_accessor :wire_counts, :wire_min_lengths

  def initialize
    self.wire_counts = [0, 0]
    self.wire_min_lengths = [Float::INFINITY, Float::INFINITY]
  end

  def step(wire_idx, length)
    self.wire_counts[wire_idx] += 1
    self.wire_min_lengths[wire_idx] += 1
    self.wire_min_lengths[wire_idx] = [self.wire_min_lengths[wire_idx], length].min
  end

  def crossing?
    self.wire_counts.all? {|count| count >= 1}
  end

  def wire_length
    self.wire_min_lengths.sum()
  end
end

wired_coords = {}

[wire_1, wire_2].each_with_index do |instructions, wire_idx|
  current_coords = {x: 0, y: 0}
  wire_length = 0

  instructions.each do |direction, steps|
    case direction
    when "U"
      dimension = :y
      heading = +1
    when "R"
      dimension = :x
      heading = +1
    when "D"
      dimension = :y
      heading = -1
    when "L"
      dimension = :x
      heading = -1
    else
      raise "unkown direction"
    end

    steps.times do
      wire_length += 1
      current_coords[dimension] += 1 * heading

      square = wired_coords.fetch(current_coords.values) { Square.new }
      square.step(wire_idx, wire_length)

      wired_coords[current_coords.values] = square
    end
  end
end

crossings = wired_coords.select { |coord, square| square.crossing? }
nearest_crossing = crossings.values.min {|square_a, square_b| square_a.wire_length <=> square_b.wire_length }

puts nearest_crossing.wire_length

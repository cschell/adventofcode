inputs = File.readlines("input.txt")

wire_1, wire_2 = inputs.map{ |wire| wire.split(",").map {|inst| [inst[0], inst[1..-1].to_i]} }

wired_coords = Hash.new([0, -1])

[wire_1, wire_2].each_with_index do |instructions, wire_idx|
  current_coords = {x: 0, y: 0}

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
      current_coords[dimension] += 1 * heading
      wired_coord = wired_coords[current_coords.values]

      if wired_coord[1] != wire_idx
        wired_coords[current_coords.values] = [wired_coord[0] + 1, wire_idx]
      else
        wired_coords[current_coords.values] = [[1, wired_coord[0]].max, wire_idx]
      end
    end
  end
end

crossings = wired_coords.select {|coord, count| count[0] > 1}

def manhatten_distance(x, y)
  x.abs + y.abs
end

nearest_crossing = crossings.keys.min {|a, b| manhatten_distance(*a) <=> manhatten_distance(*b)}

puts manhatten_distance(*nearest_crossing)

# Solution heavily based on ideas from https://www.redblobgames.com/grids/hexagons

input = File.read("input.txt")

instructions = input.split(",").map(&:strip).compact

class Coord < Struct.new(:x, :y, :z)
  def step_to(direction)
    case direction
    when "n"
      Coord.new(x    , y + 1, z - 1)
    when "s"
      Coord.new(x    , y - 1, z + 1)
    when "ne"
      Coord.new(x + 1, y    , z - 1)
    when "sw"
      Coord.new(x - 1, y    , z + 1)
    when "se"
      Coord.new(x + 1, y - 1, z    )
    when "nw"
      Coord.new(x - 1, y + 1, z    )
    else
      puts "don't know #{direction}"
    end
  end

  def distance_to_origin
    (x.abs + y.abs + z.abs) / 2
  end
end

class Step
  attr_accessor :coord

  @@register = []

  def initialize(coord)
    self.coord = coord
    @@register.push(self)
  end

  def go_to(instruction)
    next_coord = @coord.step_to(instruction)

    existing_step = @@register.find do |step|
      step.coord == next_coord
    end

    if existing_step
      return existing_step
    else
      Step.new(next_coord)
    end
  end

  def distance_to_origin
    coord.distance_to_origin
  end
end


current_step = Step.new(Coord.new(0,0,0))
furthest_distance = 0

instructions.each do |instruction|
  current_step = current_step.go_to(instruction)
  furthest_distance = [furthest_distance, current_step.distance_to_origin].max
end

puts "1: shortest distance is %s steps" % [current_step.distance_to_origin]
puts "2: furthest step was %s steps away" % [furthest_distance]

require "pp"
class Part1
  def initialize(input)
    @instructions = input
  end

  def result
    @distances = []
    @instructions.each do |instruction|
      reindeer = Reindeer.new(instruction)
      @distances << reindeer.traveled_distance_after_seconds(2503)
    end

    @distances.max
  end
end

class Reindeer
  def initialize(instruction)
    data = instruction.match(/(?<name>\w+) can fly (?<speed>\d+) km\/s for (?<fly_time>\d+) seconds, but then must rest for (?<rest_time>\d+) seconds./)
    @name = data[:name]
    @speed = data[:speed].to_i
    @fly_time = data[:fly_time].to_i
    @rest_time = data[:rest_time].to_i
  end

  def traveled_distance_after_seconds(seconds)
    distance_per_cycle = @speed * @fly_time
    cycle_time = @fly_time + @rest_time
    cycles = seconds / cycle_time
    remaining_time = seconds % cycle_time

    cycles * distance_per_cycle + [remaining_time, @fly_time].min * @speed
  end
end

require "pp"
class Part1
  def initialize(input)
    @instructions = input
  end

  def result
    @detected_things = {
      "children" => 3,
      "cats" => 7,
      "samoyeds" => 2,
      "pomeranians" => 3,
      "akitas" => 0,
      "vizslas" => 0,
      "goldfish" => 5,
      "trees" => 3,
      "cars" => 2,
      "perfumes" => 1,
    }

    @instructions.each do |instruction|
      instruction =~ /Sue (\d+): (\w+): (\d+), (\w+): (\d+), (\w+): (\d+)/
      if Sue.new({$2 => $3.to_i, $4 => $5.to_i, $6 => $7.to_i}).matches?(@detected_things)
        return $1.to_i
      end
    end

    "No match found"
  end
end

class Sue < Struct.new(:things)
  def matches?(things)
    things.merge(self.things) == things
  end
end

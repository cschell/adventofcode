require "./part1"

class Part2 < Part1


end
class Sue
  def matches?(things)
    things.each do |key, value|
      if self.things[key]
        case key
        when "cats", "trees"
          return false if value >= self.things[key]
        when "pomeranians", "goldfish"
          return false if value <= self.things[key]
        else
          return false if value != self.things[key]
        end
      end
    end
    true
  end
end

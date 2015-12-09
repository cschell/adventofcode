require "./part1"

class Part2 < Part1
  def result
    super
    @distances.max
  end
end

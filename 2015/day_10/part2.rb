require "./part1"

class Part2 < Part1
  def result
    @iterations = 50
    super
  end
end

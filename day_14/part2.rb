require "./part1"

class Part2 < Part1
  def result
    @reindeers = []
    @instructions.each do |instruction|
      @reindeers << Reindeer.new(instruction)
    end

    time_traveled = 0

    2503.times do
      time_traveled += 1

      furthest_distance = @reindeers.map { |reindeer|
        reindeer.traveled_distance_after_seconds(time_traveled)
      }.max

      @reindeers.each do |reindeer|
        reindeer.score! if reindeer.traveled_distance_after_seconds(time_traveled) == furthest_distance
      end
      furthest_distance
    end

    @reindeers.map(&:score).max
  end
end

class Reindeer
  def score
    @score || 0
  end

  def score!
    @score ||= 0
    @score += 1
  end
end

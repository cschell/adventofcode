require "json"
require "./part1"

class Part2 < Part1
  def result
    @people = get_people_from_input(@instructions)
    @people["me"] = Person.new # me
    get_max_happiness_levels_for(@people)
  end
end

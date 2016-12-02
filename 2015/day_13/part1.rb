require "pp"
class Part1
  def initialize(input)
    @instructions = input
  end

  def result
    @people = get_people_from_input(@instructions)
    get_max_happiness_levels_for(@people)
  end

  def get_people_from_input(instructions)
    people = {}

    instructions.each do |instruction|
      matches = instruction.match(/(?<person>\w+) would (?<gain_lose>\w+) (?<happiness_units>\d+) happiness units by sitting next to (?<neighbour>\w+)./)
      people[matches[:person]] ||= Person.new
      people[matches[:neighbour]] ||= Person.new
      people[matches[:person]].add_neighbour(people[matches[:neighbour]], matches[:happiness_units].to_i * (matches[:gain_lose] == "lose" ? -1 : 1))
    end

    people
  end

  def get_max_happiness_levels_for(people)
    happiness_levels = []

    @people.values.permutation.each do |arrangement_alternative|
      @seats = []

      arrangement_alternative << arrangement_alternative[0] << arrangement_alternative[1]

      arrangement_alternative.each_cons(3) do |left_neighbour, person, right_neighbour|
        @seats << Seat.new(left_neighbour, person, right_neighbour)
      end

      happiness_levels << @seats.map(&:to_i).inject(&:+)
    end

    happiness_levels.max
  end
end

class Seat < Struct.new(:left_neighbour, :person, :right_neighbour)
  def to_i
    self.person.happiness_for(self.right_neighbour) +
    self.person.happiness_for(self.left_neighbour)
  end
end

class Person
  def initialize
    @neighbour_linking = {}
  end

  def add_neighbour(neighbour, gained_happiness)
    @neighbour_linking[neighbour] = gained_happiness
  end

  def happiness_for(neighbour)
    @neighbour_linking[neighbour] || 0
  end
end

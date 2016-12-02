require "pp"
class Part1
  def initialize(input)
    @instructions = input
  end

  def result
    @cities = {}
    @instructions.each do |instruction|
      instruction =~ /(\w+) to (\w+) = (\d+)/
      city1, city2, distance = [$1, $2, $3.to_i]

      @cities[city1] ||= City.new(city1)
      @cities[city2] ||= City.new(city2)

      route = Route.new(@cities[city1], @cities[city2], distance)

      @cities[city1].add_route(route)
      @cities[city2].add_route(route)
    end

    @distances = []

    @cities.values.permutation.each do |permutated_cities|
      distance = 0
      permutated_cities.each_cons(2) do |start_city, dest_city|
        distance += start_city.distance_to(dest_city) if dest_city
      end
      @distances << distance
    end

    @distances.min
  end

  class City < Struct.new(:name)
    def distance_to(city)
      @routes.select { |route| route.to?(city) }[0].distance
    end

    def add_route(route)
      @routes ||= []
      @routes << route
    end
  end

  class Route < Struct.new(:city1, :city2, :distance)
    def to?(city)
      self.city1 == city || self.city2 == city
    end
  end
end

module Day3
  class Part1
    def initialize(input)
      @instructions = input[0]
    end

    def result
      santas_route = Route.new

      @instructions.chars.each do |direction|
        santas_route.go(direction)
      end

      santas_route.houses_visited.uniq.count
    end
  end

  class Part2
    def initialize(input)
      @instructions = input[0]
    end

    def result
      santas_route = Route.new
      robo_santas_route = Route.new

      @instructions.chars.each_slice(2) do |santas_direction, robo_santas_direction|
        santas_route.go(santas_direction)
        robo_santas_route.go(robo_santas_direction)
      end

      [santas_route, robo_santas_route].map(&:houses_visited)
                                       .inject(&:+)
                                       .uniq
                                       .count
    end
  end

  class Route
    attr_reader :houses_visited

    def initialize
      @current_house = {x: 0, y: 0}
      @houses_visited = []

      @houses_visited << @current_house.clone
    end

    def go(direction)
      case direction
      when ">" then
        @current_house[:x] += 1
      when "^" then
        @current_house[:y] += 1
      when "v" then
        @current_house[:y] -= 1
      when "<" then
        @current_house[:x] -= 1
      end

      @houses_visited << @current_house.clone
    end
  end
end

require "pp"
class Part1
  def initialize(input)
    @containers = input.map { |c|
      Container.new(c.chomp.to_i)
    }
  end

  def result
    combination_count_for(@containers, 150)
  end

  def combination_count_for(containers, capacity)
    if capacity == 0
      return 1
    elsif capacity < 0
      return 0
    end

    combination_count = 0

    containers.each_with_index do |container, index|
      combination_count += combination_count_for(containers[(index+1)..-1], capacity - container.capacity)
    end

    combination_count
  end
end


class Container < Struct.new(:capacity)
end

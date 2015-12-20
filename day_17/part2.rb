class Part2
  def initialize(input)
    @containers = input.map { |c|
      Container.new(c.chomp.to_i)
    }
  end

  def result
    @all_the_combinations = []
    combination_count_for(@containers, 150)
    min_count = @all_the_combinations.map(&:count).min
    @all_the_combinations.select {|comb| comb.count == min_count}.count
  end

  def combination_count_for(containers, capacity, current_combination = [])
    if capacity == 0
      @all_the_combinations << current_combination
      return 1
    elsif capacity < 0
      return 0
    end

    combination_count = 0

    containers.each_with_index do |container, index|
      combination_count += combination_count_for(containers[(index+1)..-1], capacity - container.capacity, current_combination + [container])
    end

    combination_count
  end
end

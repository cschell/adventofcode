require "matrix"

module Day1
  class Part1
    def initialize(input)
      @instructions = input[0]
    end

    def result
      @instructions.gsub("(", "1,").gsub(")", "-1,").split(",").map(&:to_i).inject(&:+)
    end
  end

  class Part2
    def initialize(input)
      @instructions = input[0]
    end

    def result
      current_floor = 0
      @instructions.gsub("(", "1,").gsub(")", "-1,").split(",").map(&:to_i).each_with_index do |instruction, index|
        current_floor += instruction
        return (index + 1) if current_floor == -1
      end
    end
  end
end

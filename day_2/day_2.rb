require "matrix"

module Day2
  class Part1
    def initialize(input)
      @instructions = input
    end

    def result
      all_the_paper_needed = 0
      @instructions.each do |instruction|
        length, width, height = instruction.split("x").map(&:to_i)

        slack = [length * height, width * height, width * length].min

        all_the_paper_needed += 2 * length * width + 2 * width * height + 2 * height * length + slack
      end
      all_the_paper_needed
    end
  end

  class Part2
    def initialize(input)
      @instructions = input[0]
    end

    def result
    end
  end
end

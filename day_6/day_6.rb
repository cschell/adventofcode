require "matrix"

class Day6
  def initialize(input)
    @instructions = input
    @grid = Grid.new
  end

  def result
    @instructions.each do |instruction|
      match = instruction.match(/(?<command>[^\d]+) (?<corner_a_row>\d+),(?<corner_a_col>\d+) through (?<corner_b_row>\d+),(?<corner_b_col>\d+)/)
      @grid.send(match[:command].gsub(" ", "_"),
                [match[:corner_a_row], match[:corner_a_col]],
                [match[:corner_b_row], match[:corner_b_col]])
    end

    @grid.count_on
  end

  class Grid
    def initialize
      @lights = Matrix.zero(1000, 1000)
    end

    def turn_on(corner_a, corner_b)
      set_sector(corner_a, corner_b, 1)
    end

    def turn_off(corner_a, corner_b)
      set_sector(corner_a, corner_b, 0)
    end

    def toggle(corner_a, corner_b)
      set_sector(corner_a, corner_b) do |value|
        (value + 1) - value * 2
      end
    end

    def count_on
      count = 0

      @lights.each do |light|
        count += 1 if light == 1
      end
      count
    end

    def set_sector(corner_a, corner_b, value = nil)
      top, bottom = [corner_a[0], corner_b[0]].sort
      left, right = [corner_a[1], corner_b[1]].sort

      @lights.each_with_index do |e, row_index, col_index|
        if ((top..bottom).cover?(row_index)) &&
          ((left..right).cover?(col_index))

          value ||= yield(e) if block_given?

          @lights.send("[]=", row_index, col_index, value)
        end
      end
    end

    def inspect
      @lights.each_with_index do |e, row_index, col_index|
        if col_index == 0
          print "\n"
        else
          print e == 0 ? "." : ","
        end
      end
    end
  end
end

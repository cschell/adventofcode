require "pp"

class Part1
  def initialize(input)
    @instructions = input
  end

  def result
    initial_field = Matrix[*@instructions.map(&:chomp).map(&:chars)]
    game = Game.new(initial_field)

    100.times do
      game.next
      game.to_stdout
    end

    Curses.close_screen
    game.count_living
  end
end

require "matrix"
require "curses"

Curses.noecho
Curses.init_screen

class Game
  attr_reader :field

  def initialize(raw_initial_field)
    @field = parse_raw_field(raw_initial_field)

    @width = @field.row_count
    @height = @field.column_count
  end

  def next
    @field = Matrix.build(@width, @height) do |row, column|
      @field[row, column].next_generation(neighbours_of(row, column))
    end
  end

  def to_stdout
    @field.to_a.each_with_index do |row, index|
      Curses.setpos(index, 0)
      Curses.addstr(row.join(" "))
      Curses.refresh
    end
  end

  def count_living
    count = 0
    @field.each do |cell|
      count += 1 if cell.living?
    end
    count
  end

  private

  def parse_raw_field(field_matrix)
    field_matrix.map do |field|
      case field
      when "."
        DeadCell.new
      when "#"
        LivingCell.new
      else
        raise "Could't identify #{field}"
      end
    end
  end

  def neighbours_of(row, column)
    neighbour_offsets = [-1, 0, +1].repeated_permutation(2)
                                   .reject {|c| c == [0,0]}

    neighbour_offsets.map do |row_offset, column_offset|
      neighbour_row = row + row_offset
      neighbour_col = column + column_offset
      if neighbour_row >= 0 && neighbour_col >= 0
        @field[neighbour_row, neighbour_col]
      end
    end.compact
  end
end

class Cell
  def next_generation(neighbours)
    case neighbours.select(&:living?).count
    when 2
      do_nothing!
    when 3
      live!
    else
      be_dead!
    end
  end

  def living?
    false
  end

  def do_nothing!
    self
  end

  def be_dead!
    DeadCell.new
  end

  def live!
    LivingCell.new
  end
end

class LivingCell < Cell
  def to_s
    '#'
  end

  def living?
    true
  end
end

class DeadCell < Cell
  def to_s
    '.'
  end
end

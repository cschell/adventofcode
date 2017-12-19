require "pp"
require "matrix"

input = File.read "input.txt"

maze = Matrix[*input.each_line.map {|l| l.split("").reject {|c| c == "\n" } }.reject(&:empty?)]

start = maze.row(0).to_a.index("|")

class Path
  def initialize(maze)
    @maze = maze
    @found_chars = []
    @step_count = 0
  end

  def walk_through(start)
    current_step = StepDown.new(start, 0, @maze)

    catch(:end) do
      loop do
        @step_count += 1

        if char = current_step.char
          @found_chars << char
        end

        current_step = current_step.next_step
      end
    end

    [@found_chars.join, @step_count]
  end
end

class Step < Struct.new(:x, :y, :maze)
  def initialize(*attrs)
    super(*attrs)

    if type == " "
      throw :end
    end
  end

  def char
    type[/\w/]
  end

  def type
    maze[y, x]
  end

  def next_step
    next_step_class.from(self)
  end

  def next_step_class
    case type
    when "+"
      search_for_turn
    else
      self.class
    end
  end
end

class StepUp < Step
  def self.from(origin)
    new(origin.x, origin.y - 1, origin.maze)
  end

  def search_for_turn
    if maze[y, x - 1] != " "
      StepLeft
    else
      StepRight
    end
  end
end

class StepDown < Step
  def self.from(origin)
    new(origin.x, origin.y + 1, origin.maze)
  end

  def search_for_turn
    if maze[y, x - 1] != " "
      StepLeft
    else
      StepRight
    end
  end
end

class StepRight < Step
  def self.from(origin)
    new(origin.x + 1, origin.y, origin.maze)
  end

  def search_for_turn
    if maze[y - 1, x] != " "
      StepUp
    else
      StepDown
    end
  end
end

class StepLeft < Step
  def self.from(origin)
    new(origin.x - 1, origin.y, origin.maze)
  end

  def search_for_turn
    if maze[y - 1, x] != " "
      StepUp
    else
      StepDown
    end
  end
end

path = Path.new(maze)
pp path.walk_through(start)


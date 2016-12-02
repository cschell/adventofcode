require "./part1"

class Part2 < Part1
end

class Game
  def next
    enlive_corner_cells

    @field = Matrix.build(@width, @height) do |row, column|
      @field[row, column].next_generation(neighbours_of(row, column))
    end

    enlive_corner_cells
  end

  def enlive_corner_cells
    corners = [[0, 0],[-1,-1],[-1, 0], [0, -1]]
    corners.each do |corner|
      @field.send(:[]=, corner[0], corner[1], LivingCell.new)
    end
  end
end

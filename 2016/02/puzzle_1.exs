defmodule Day01Puzzle1 do
  @commands %{
    "U" => %{x:  0, y: -1},
    "D" => %{x:  0, y:  1},
    "R" => %{x:  1, y:  0},
    "L" => %{x: -1, y:  0},
    "" => %{x: 0, y:  0}
  }

  @numpad [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9]
  ]

  def new_position(current_position, command) do
    new_x = current_position.x + command.x
    new_y = current_position.y + command.y

    if new_x < 0 || 2 < new_x do
      new_x = current_position.x
    end

    if new_y < 0 || 2 < new_y do
      new_y = current_position.y
    end

    %{
      x: new_x,
      y: new_y
    }
  end

  def get_combination(instruction_sets), do: get_combination(instruction_sets, %{x: 1, y: 1})

  def get_combination([], _), do: []

  def get_combination([""], _), do: []

  def get_combination([instruction_set | instruction_sets], start_position) do
    new_position = String.split(instruction_set, "")
      |> get_last_position(start_position)

    [get_num(new_position), get_combination(instruction_sets, new_position)]
      |> List.flatten
      |> Enum.join
  end


  def get_num(position) do
    @numpad
      |> Enum.at(position.y)
      |> Enum.at(position.x)
  end

  def get_last_position([], current_position), do: current_position

  def get_last_position([instruction | instructions], current_position) do
    new_pos = new_position(current_position, @commands[instruction])
    get_last_position(instructions, new_pos)
  end
end

{:ok, contents} = File.read("./input.txt")
IO.puts String.split(contents, "\n") |>
        Day01Puzzle1.get_combination

defmodule Day08Puzzle01 do
  @rows 6
  @cols 50

  def run do
    {:ok, contents} = File.read("./input.txt")

    initial_display = Enum.map(1..@rows, fn(_) -> Enum.map(1..@cols, fn(_) -> :off end) end)

    instructions = contents
      |> String.split("\n")
      |> split_instructions

    final_display = initial_display
      |> process_instructions(instructions)

    IO.write "Turned on lights: "
    final_display
      |> Enum.map(&(Enum.count(&1, fn(l) -> l == :on end)))
      |> Enum.sum
      |> IO.puts

    IO.puts("")

    print(final_display)
  end

  defp split_instructions(instructions) do
    instructions |> Enum.map(&( String.split(&1, " ") ))
  end

  defp process_instructions(display, [instruction | instructions]) do
    display
      |> execute(instruction)
      |> process_instructions(instructions)
  end

  defp process_instructions(display, _) do
    display
  end

  defp print(display) do
    display
      |> Enum.each(fn(row) ->
        Enum.each(row, fn(elem)->
          case elem do
            :on -> IO.write("#")
            :off -> IO.write(".")
          end
        end)
        IO.puts("")
      end)
    display
  end

  defp execute(display, ["rect", size]) when is_list(display) do
    [x,y] = String.split(size, "x")
              |> Enum.map(&String.to_integer/1)
    turn_rect_on(display, {x, y})
  end

  defp execute(display, ["rotate", "row", row_description, "by", count]) when is_list(display) do
    [_, row_index] = String.split(row_description, "=")
    row_index = String.to_integer(row_index)

    display
      |> get_row(row_index)
      |> rotate_list_by(String.to_integer(count))
      |> insert_row_at(row_index, display)
  end

  defp execute(display, ["rotate", "column", col_description, "by", count]) when is_list(display) do
    [_, col_index] = String.split(col_description, "=")
    col_index = String.to_integer(col_index)

    display
      |> get_col(col_index)
      |> rotate_list_by(String.to_integer(count))
      |> insert_col_at(col_index, display)
  end

  defp execute(display, _) do
    display
  end

  defp turn_rect_on(display, {x, y}) when is_list(display) do
    Enum.reduce(0..max(0, y - 1), display, fn(row_index, display) ->
      Enum.reduce(0..max(0, x - 1), display, fn(col_index, display)->
        get_row(display, row_index)
          |> List.replace_at(col_index, :on)
          |> insert_row_at(row_index, display)
      end)
    end)
  end

  defp get_row(display, row_num) do
    Enum.at(display, row_num)
  end

  defp get_col(display, col_num) do
    Enum.map display, fn(row) ->
      Enum.at(row, col_num)
    end
  end

  defp insert_row_at(new_row, row_index, display) do
    List.replace_at(display, row_index, new_row)
  end

  defp insert_col_at(new_col, col_index, display) do
    Enum.with_index(new_col)
      |> Enum.map(fn({new_elem, row_index}) ->
          display
            |> Enum.at(row_index)
            |> List.replace_at(col_index, new_elem)
         end)
  end

  defp rotate_list_by(row, 0) do
    row
  end

  defp rotate_list_by([ first_elem | remaining_row ], count) when count < 0 do
    rotate_list_by(remaining_row ++ [first_elem], count + 1)
  end

  defp rotate_list_by(row, count) when count > 0 do
    last_elem = List.last(row)
    remaining_row = Enum.slice(row, 0..-2)
    rotate_list_by([last_elem] ++ remaining_row, count - 1)
  end
end



Day08Puzzle01.run

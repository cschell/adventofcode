import Enum
{:ok, contents} = File.read("./input.txt")
contents
  |> String.split("\n")
  |> map( fn(line) ->
      Regex.scan(~r/(\d+)\s*(\d+)\s*(\d+)/, line)
        |> List.flatten
        |> slice(1..3)
        |> map(&(String.to_integer(&1)))
    end)
  |> filter(&(count(&1) == 3))
  |> chunk(3)
  |> map(fn(lines) ->
      [line_1, line_2, line_3] = lines
      [
        [at(line_1, 0), at(line_2, 0), at(line_3, 0)],
        [at(line_1, 1), at(line_2, 1), at(line_3, 1)],
        [at(line_1, 2), at(line_2, 2), at(line_3, 2)]
      ]
    end)
  |> concat
  |> map(fn(sides) ->
      [side_a, side_b, side_c] = sides
      side_a + side_b > side_c &&
      side_a + side_c > side_b &&
      side_b + side_c > side_a
    end)
  |> count(&(&1))
  |> IO.puts

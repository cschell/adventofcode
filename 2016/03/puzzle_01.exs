{:ok, contents} = File.read("./input.txt")
contents
  |> String.split("\n")
  |> Enum.map( fn(line) ->
      Regex.scan(~r/(\d+)\s*(\d+)\s*(\d+)/, line)
        |> List.flatten
        |> Enum.slice(1..3)
        |> Enum.map(&(String.to_integer(&1)))
    end)
  |> Enum.map( fn(sides) ->
      side_count = Enum.count(sides)
      case side_count do
        3 ->
          [side_a, side_b, side_c] = sides
          side_a + side_b > side_c &&
          side_a + side_c > side_b &&
          side_b + side_c > side_a
        _ ->
          false
      end
    end)
  |> Enum.count(&(&1))
  |> IO.puts

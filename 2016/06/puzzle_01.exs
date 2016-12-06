{:ok, contents} = File.read("./input.txt")

contents
  |> String.split("\n")
  |> Enum.reduce(%{}, fn(line, register) ->
    to_char_list(line)
      |> Enum.with_index
      |> Enum.reduce(register, fn(char_with_index, sub_register) ->
          {char, index} = char_with_index
          Map.update(sub_register, index, %{}, fn(bar_register)->
            Map.update(bar_register, [char], 1, fn(char_count)->
              char_count + 1
            end)
          end)
        end)
    end)
  |> Enum.map(fn({_index, register}) ->
    register
      |> Enum.to_list
      |> Enum.sort_by(&(elem(&1, 1)), &>=/2)
    end)
  |> Enum.map(&(elem(hd(&1),0)))
  |> Enum.join
  |> IO.puts

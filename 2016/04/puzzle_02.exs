{:ok, contents} = File.read("./input.txt")

{good_codes, _fake} = contents
                        |> String.split("\n")
                        |> Enum.map( fn(line) ->
                            Regex.named_captures(~r/(?<code>\D+)-(?<id>\d+)\[(?<checksum>\w+)\]/, line)
                          end)
                        |> Enum.partition(fn(code) ->
                            if code["code"] do
                              target_checksum = code["code"]
                                                |> String.split("")
                                                |> Enum.reduce(%{}, fn(letter, acc) ->
                                                  if letter != "" && letter != "-" do
                                                    Map.update(acc, letter, 1, &(&1 + 1))
                                                  else
                                                    acc
                                                  end
                                                end)
                                                |> Map.to_list
                                                |> Enum.sort_by(&(&1), fn(a, b) ->
                                                    {letter_a, count_a} = a
                                                    {letter_b, count_b} = b
                                                    cond do
                                                      count_a != count_b ->
                                                        count_a > count_b
                                                      true ->
                                                        letter_a <= letter_b
                                                    end
                                                  end)
                                                |> Enum.map(&(elem(&1,0)))
                                                  |> Enum.take(5)
                                                  |> Enum.join
                              target_checksum == code["checksum"]
                            else
                              false
                            end
                          end)

good_codes
  |> Enum.map(fn(code) ->
      {code["id"], Enum.map(to_char_list(code["code"]), fn(char) ->
        Enum.reduce(1..String.to_integer(code["id"]), char, fn(current_char, last_char) ->
          cond do
            last_char == ?\s || last_char == ?- ->
              ?\s
            last_char >= ?z ->
              ?a
            last_char in ?a..?z ->
              last_char + 1
          end
        end)
      end)}
    end)
  |> Enum.group_by(&(elem(&1, 0)))
  |> Enum.each(fn ({id, rooms}) ->
    IO.puts "#{id}:"
    Enum.each(rooms, fn(room) ->
      {_, name} = room
      IO.puts "    #{name}"
    end)
  end)


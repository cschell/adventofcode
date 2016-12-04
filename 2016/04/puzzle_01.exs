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
  |> Enum.reduce(0, &(String.to_integer(&1["id"]) + &2))
  |> IO.puts


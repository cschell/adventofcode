defmodule Day05Puzzle02 do
  def find_password_hash(door_id, index, password_hash \\ [nil, nil, nil, nil, nil, nil, nil, nil]) do
    hash = :crypto.hash(:md5, "#{door_id}#{index}") |> Base.encode16

    if Regex.match?(~r/^0{5}/, hash) do
      position = case Integer.parse(String.at(hash, 5)) do
        {num, _} ->
          num
        :error ->
          nil
      end

      char = String.at(hash, 6)

      password_hash = cond do
                        position in 0..7 && !Enum.at(password_hash, position) ->
                          List.replace_at(password_hash, position, char)
                        true ->
                          password_hash
                      end
    end

    if(rem(index, 10000) == 0) do
      hacker_password_output(password_hash)
    end

    if Enum.all?(password_hash) do
      password_hash
    else
      find_password_hash(door_id, index + 1, password_hash)
    end
  end

  def hacker_password_output(password_hash) do
    hacker_password_hash = password_hash
                            |> Enum.map(fn(char) ->
                                case char do
                                  nil ->
                                    [Enum.random(40..90)]
                                  _ ->
                                    char
                                end
                              end)
                            |> Enum.join
    IO.write hacker_password_hash <> "\r"
  end
end

input = 'cxdnnyjw'
IO.puts Day05Puzzle02.find_password_hash(input, 0)

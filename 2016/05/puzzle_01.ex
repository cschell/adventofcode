defmodule Day05Puzzle01 do
  def hash_door_id(door_id), do: hash_door_id(door_id, 0, 0)

  def hash_door_id(door_id, index, cycle_count) when cycle_count < 8 do
    {index, password_char} = find_password_char(door_id, index)
    password_char <> hash_door_id(door_id, index + 1, cycle_count + 1)
  end

  def hash_door_id(_, _, _), do: ""

  def find_password_char(door_id, index) do
    hash = :crypto.hash(:md5, "#{door_id}#{index}") |> Base.encode16

    if Regex.match?(~r/^0{5}/, hash) do
      {index, String.at(hash, 5)}
    else
      find_password_char(door_id, index + 1)
    end
  end
end

input = 'cxdnnyjw'
IO.puts Day05Puzzle01.hash_door_id(input)

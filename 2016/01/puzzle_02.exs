defmodule Location do
  defstruct x: 0, y: 0

  def all_locations_between(location_a = %Location{}, location_b = %Location{}) when location_a == location_b do
    []
  end

  def all_locations_between(location_a = %Location{}, location_b = %Location{}) do
    unless location_a.x == location_b.x or location_a.y == location_b.y do
      raise "cannot calc locations"
    end

    locations = cond do
                  location_a.x - location_b.x > 0 ->
                    all_locations_between(%Location{x: location_a.x - 1, y: location_a.y}, location_b)
                  location_a.x - location_b.x < 0 ->
                    all_locations_between(%Location{x: location_a.x + 1, y: location_a.y}, location_b)
                  location_a.y - location_b.y > 0 ->
                    all_locations_between(%Location{x: location_a.x, y: location_a.y - 1}, location_b)
                  location_a.y - location_b.y < 0 ->
                    all_locations_between(%Location{x: location_a.x, y: location_a.y + 1}, location_b)
                end

    [location_a | locations]
  end

  def find_first_double_visited_location([]), do: :nope

  def find_first_double_visited_location([current_location | locations]) do
    cond do
      Enum.find_value(locations, &(&1 == current_location)) ->
        current_location
      :default ->
        find_first_double_visited_location(locations)
    end
  end

  def distance_from_zero(location = %Location{}) do
    abs(location.x) + abs(location.y)
  end
end

defmodule Position do
  defstruct heading: 0, location: %Location{x: 0, y: 0}
end

defmodule Instruction do
  defstruct direction: "R", block_count: 0

  def parse(raw_instructions) do
    instructions = Enum.map(Regex.scan(~r/(\w)(\d+),?\s/, raw_instructions), fn raw_instruction ->
        [_, direction, block_count] = raw_instruction
        %Instruction{direction: direction, block_count: String.to_integer(block_count)}
      end)
    instructions
  end


  def follow(instructions) do
    follow(instructions, %Position{})
  end

  def follow([], current_position), do: [current_position.location]

  def follow([ instruction | instructions ], current_position = %Position{}) do
    next_position = next_position(instruction, current_position)
    List.flatten(Location.all_locations_between(current_position.location, next_position.location), follow(instructions, next_position))
  end

  defp next_position(instruction = %Instruction{}, current_position = %Position{}) do
    next_heading = next_heading(instruction.direction, current_position.heading)
    next_location = next_location(current_position.location, next_heading, instruction.block_count)

    %Position{
      heading: next_heading,
      location: next_location
    }
  end

  defp next_heading("R", 3) do
    0
  end

  defp next_heading("R", heading) do
    heading + 1
  end

  defp next_heading("L", 0) do
    3
  end

  defp next_heading("L", heading) do
    heading - 1
  end

  defp next_location(current_location, _next_heading = 0, block_count) do
    %Location{
      y: current_location.y + block_count,
      x: current_location.x
    }
  end

  defp next_location(current_location, _next_heading = 1, block_count) do
    %Location{
      y: current_location.y,
      x: current_location.x + block_count
    }
  end

  defp next_location(current_location, _next_heading = 2, block_count) do
    %Location{
      y: current_location.y - block_count,
      x: current_location.x
    }
  end

  defp next_location(current_location, _next_heading = 3, block_count) do
    %Location{
      y: current_location.y,
      x: current_location.x - block_count
    }
  end
end


{:ok, raw_instructions} = File.read "./input.txt"
instructions = Instruction.parse(raw_instructions)
locations = Instruction.follow(instructions)

target_location = Location.find_first_double_visited_location(locations)

distance = Location.distance_from_zero(target_location)

IO.puts "The shortest path is #{distance} blocks."

defmodule Location do
  defstruct x: 0, y: 0
end

defmodule Position do
  defstruct heading: 0, location: %Location{x: 0, y: 0}

  def to_string(position = %Position{}) do
    "(x: #{position.location.x}, y: #{position.location.y}), facing #{position.heading}, #{distance_from_zero(position)} blocks away from zero"
  end

  def distance_from_zero(position = %Position{}) do
    abs(position.location.x) + abs(position.location.y)
  end
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

  def follow([], current_position), do: current_position

  def follow([ instruction | instructions ], current_position = %Position{}) do
    follow(instructions, np, next_position(instruction, current_position))
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
final_position = Instruction.follow(instructions)
distance = Position.distance_from_zero(final_position)

IO.puts "The shortest path is #{distance} blocks."

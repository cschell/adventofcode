#!/usr/bin/env ruby

require "./day_6"

File.open("input.txt") do |file|
  lines = file.each_line.to_a

  puts "Solving part 1..."
  part1 = Day6::Part1.new(lines)
  result1 = part1.result
  puts "Result part 1: #{result1}"

  puts "Solving part 2..."
  part2 = Day6::Part2.new(lines)
  result2 = part2.result
  puts "Result part 2: #{result2}"
end

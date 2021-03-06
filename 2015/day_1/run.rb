#!/usr/bin/env ruby

require "./day_1"

File.open("input.txt") do |file|
  lines = file.each_line.to_a

  puts "Solving part 1..."
  part1 = Day1::Part1.new(lines)
  result1 = part1.result
  puts "Result part 1: #{result1}"


  puts "Solving part 2..."
  part2 = Day1::Part2.new(lines)
  result2 = part2.result
  puts "Result part 2: #{result2}"
end

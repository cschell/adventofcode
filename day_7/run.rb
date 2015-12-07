#!/usr/bin/env ruby

require "./day_7"

File.open("input.txt") do |file|
  lines = file.each_line.to_a

  part1 = Day7::Part1.new(lines)
  result1 = part1.result
  puts "Result part1: #{result1}"

  part2 = Day7::Part2.new(lines)
  result2 = part2.result
  puts "Result part2: #{result2}"
end

#!/usr/bin/env ruby

require "./day_6"

File.open("input.txt") do |file|
  puts "Solving part 1..."
  part1 = Day6::Part1.new(file.each_line)
  result1 = part1.result
  puts "Result part 1: #{result1}"
end

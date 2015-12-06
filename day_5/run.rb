#!/usr/bin/env ruby

require "./day_5"

File.open("input.txt") do |file|
  lines = file.each_line.to_a

  part1 = Day5::Part1.new(lines)
  puts "Result part1: #{part1.result} words are nice"

  part2 = Day5::Part2.new(lines)
  puts "Result part2: #{part2.result} words are nice"
end

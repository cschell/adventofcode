#!/usr/bin/env ruby

require "./part1"
require "./part2"

File.open("input.txt") do |file|
  lines = file.each_line.to_a

  part1 = Part1.new(lines)
  # result1 = part1.result
  # puts "Result part1: #{result1}"

  part2 = Part2.new(lines)
  result2 = part2.result
  puts "Result part2: #{result2}"
end

#!/usr/bin/env ruby

require "./day_6"

File.open("input.txt") do |file|
  day6 = Day6.new(file.each_line)
  puts day6.result
end

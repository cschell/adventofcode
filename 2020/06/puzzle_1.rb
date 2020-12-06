require "set"

groups = File.read("input.txt").split("\n\n")

puts(groups.map {|g| Set.new(g.gsub("\n", "").split("")).count()}.inject(:+))
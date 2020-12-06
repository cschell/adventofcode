require "set"

groups = File.read("input.txt").split("\n\n")

puts(groups.map {|g| g.split("\n").map{|line| line.split("")}.inject(:&).count() }.inject(:+))
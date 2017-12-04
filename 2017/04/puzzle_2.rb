input = File.read("input.txt")

valid = input.each_line.map do |line|
  words = line.split(" ").map {|word| word.split("").sort }

  words.group_by { |word| word.group_by {|char| char} }
    .select { |_, v| v.size > 1 }
    .flatten
    .empty?
end.count(true)

puts valid

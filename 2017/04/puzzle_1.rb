require "pp"
input = File.read("input.txt")

valid = input.each_line.map do |line|
  words = line.split(" ")

  words.group_by{ |word| word }
    .select { |_, same_words| same_words.size > 1 }
    .flatten
    .empty?
end.count(true)

puts(valid)

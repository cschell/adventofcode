box_ids = File.readlines("./input.txt")

two_letter_counter = 0
three_letter_counter = 0

box_ids.map do |box_id|
  unique_letters = box_id.chomp.split("").uniq

  twos_counted = false
  threes_counted = false

  unique_letters.each do |letter|
    case box_id.count(letter)
    when 2
      two_letter_counter += 1 unless twos_counted
      twos_counted = true
    when 3
      three_letter_counter += 1 unless threes_counted
      threes_counted = true
    end
  end
end

puts two_letter_counter * three_letter_counter

input = 367479..893698

012345
124446

puts(input.count do |number|
  number = number.to_s
  rule_three = false
  rule_four = true

  chunked_counts = number.split("").chunk {|a| a}.map {|_, occurrences| occurrences.count }
  rule_three = chunked_counts.any? {|count| count == 2}

  5.times do |idx|
    if number[idx].to_i > number[idx+1].to_i
      rule_four = false
    end
  end

  rule_three && rule_four
end)

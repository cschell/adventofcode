input = 367479..893698

puts(input.count do |i|
  rule_three = false
  rule_four = true

  5.times do |idx|
    if i.to_s[idx] == i.to_s[idx+1]
      rule_three = true
    end
  end

  5.times do |idx|
    if i.to_s[idx].to_i > i.to_s[idx+1].to_i
      rule_four = false
    end
  end

  rule_three && rule_four
end)

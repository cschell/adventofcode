input = 312051

next_sqrt = Math.sqrt(input).ceil
puts "next_sqrt is #{next_sqrt}"
rings_bottom_right_corner_value = if next_sqrt % 2 == 0
                                    (next_sqrt + 1) ** 2
                                  else
                                    next_sqrt ** 2
                                  end
puts "rings_bottom_right_corner_value is #{rings_bottom_right_corner_value}"

inter_ring_steps = (Math.sqrt(rings_bottom_right_corner_value) / 2).floor

lowest_ring_value = ((Math.sqrt(rings_bottom_right_corner_value) - 1) ** 2 + 1).to_i

ring_steps = inter_ring_steps
direction = 1

rings_bottom_right_corner_value.downto(lowest_ring_value).each do |cell|
  puts "#{cell} => #{ring_steps}"
  if cell == input
    break
  end

  if ring_steps >= inter_ring_steps || ring_steps <= 0

    direction *= -1
  end


  ring_steps += direction * 1
  raise "foo" if ring_steps > inter_ring_steps
end

puts "inter_ring_steps are %s" % [inter_ring_steps]
puts "ring_steps are %s" % [ring_steps]

puts "sum is %s" % [inter_ring_steps + ring_steps]

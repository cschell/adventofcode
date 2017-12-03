input = 312051

next_sqrt = Math.sqrt(input).ceil

rings_bottom_right_corner_value = if next_sqrt % 2 == 0
                                    (next_sqrt + 1) ** 2
                                  else
                                    next_sqrt ** 2
                                  end

inter_ring_steps = (Math.sqrt(rings_bottom_right_corner_value) / 2).floor

lowest_ring_value = ((Math.sqrt(rings_bottom_right_corner_value) - 1) ** 2 + 1).to_i

ring_steps = inter_ring_steps

direction = 1

rings_bottom_right_corner_value.downto(lowest_ring_value).each do |cell|
  if cell == input
    break
  end

  if ring_steps >= inter_ring_steps || ring_steps <= 0
    direction *= -1
  end

  ring_steps += direction * 1
end

puts inter_ring_steps + ring_steps

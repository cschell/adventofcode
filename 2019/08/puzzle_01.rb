pixels = File.read("input.txt").chomp.split("").map(&:to_i)

min_0_layer = pixels.each_slice(25*6).min {|layer_a, layer_b| layer_a.count(0) <=> layer_b.count(0)}

puts min_0_layer.count(1) * min_0_layer.count(2)

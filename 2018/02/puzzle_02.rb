box_ids = File.readlines("./input.txt")
box_ids = box_ids.map { |id| id.chomp.split("") }

similar_box_ids = box_ids.map do |box_id_a|
  box_ids.find do |box_id_b|
    box_id_a.zip(box_id_b).count { |a,b| a != b } == 1
  end
end.compact

puts((similar_box_ids.transpose.select {|a,b| a == b }).transpose.first.join)

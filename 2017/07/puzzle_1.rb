input = File.read("input.txt")

class Node < Struct.new(:id, :parent)

end

nodes = input.each_line.map {|line| line[/^\w+/] }

input.each_line do |instruction|
  _, _, *children_node_ids = instruction.scan(/(\w+)/).flatten

  children_node_ids.each do |child_node_id|
    nodes.delete(child_node_id)
  end
end

puts nodes[0]

input = File.read("input.txt")

class Node < Struct.new(:id, :eigen_weight, :children, :parent)
  def initialize(*attrs)
    super
    self.children ||= []
  end

  def weight
    @weight ||= eigen_weight + children.map(&:weight).inject(0, :+)
  end

  def check_children(found_imbalance = false)
    weights = children.map(&:weight)

    if found_imbalance
      puts "#{id}: #{children.map(&:id)} = #{children.map(&:weight).inject(0, &:+)}"
      puts "#{id}: #{weights}"
    end

    if found_imbalance && children == []
      puts weight
      return
    end

    if weights.uniq.length != 1
      odd_weight = weights.group_by(&:to_i).select {|k,v| v.size == 1}.keys.first
      child = children[weights.find_index(odd_weight)]
      puts "#{id}: found imbalance in #{child.id}"
      child.check_children(found_imbalance: true)
    elsif found_imbalance
      puts "#{id} children are balanced again. My weight is #{eigen_weight}"
    else
      children.each(&:check_children)
    end
  end

  def root
    if parent
      parent
    else
      self
    end
  end
end

nodes = input.each_line.map {|line| Node.new(line[/^\w+/], line[/\d+/].to_i) }
remaining_nodes = []
all_nodes = nodes.dup

input.each_line do |instruction|
  parent_node_id, _, *children_node_ids = instruction.scan(/(\w+)/).flatten

  parent_node = all_nodes.find { |node| node.id == parent_node_id }

  children_node_ids.each do |child_node_id|
    child_node = nodes.find { |node| node.id == child_node_id }

    child_node.parent = parent_node
    parent_node.children += [child_node]

    nodes.delete(child_node)
  end

end

root = nodes.first

root.check_children

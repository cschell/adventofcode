input = File.read("input.txt")
instructions = input.scan(/\d+/).map(&:to_i)

class Node < Struct.new(:num_children, :num_metadata, :parent)
  attr_accessor :metadata

  def num_open_children
    num_children - children.find_all(&:closed?).count
  end

  def current_open_children
    children.reject(&:closed?)
  end

  def closed?
    @closed
  end

  def close!
    @closed = true
  end

  def add_child(*child_attrs)
    child_node = Node.new(*child_attrs, self)
    @children ||= []
    @children.push(child_node)
    child_node
  end

  def children
    @children || []
  end

  def closable_parents
    if parent && parent.num_open_children == 1
      [parent, parent.closable_parents].flatten
    else
      []
    end
  end

  def sum_all_metadata
    metadata.sum + children.map(&:sum_all_metadata).sum
  end

  def part_2_metadata
    if children.any?
      metadata.map do |idx|
        children[idx - 1] ? children[idx - 1].part_2_metadata : 0
      end.sum
    else
      metadata.sum
    end
  end
end

nodes = []

while instructions.any? do
  num_children = instructions.shift
  num_metadata = instructions.shift

  node = if nodes.any?
           parent_node = nodes.reject(&:closed?).last
           parent_node.add_child(num_children, num_metadata)
         else
           @root_node = Node.new(num_children, num_metadata)
         end

  nodes.push(node)

  if node.num_children == 0
    node.metadata = instructions.shift(node.num_metadata)

    node.closable_parents.each do |p_node|
      p_node.metadata = instructions.shift(p_node.num_metadata)
      p_node.close!
    end
    node.close!
  end
end

puts "Part 1: #{@root_node.sum_all_metadata}"
puts "Part 2: #{@root_node.part_2_metadata}"

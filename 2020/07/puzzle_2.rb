require "set"

rules = File.read("input.txt")


class BagType
  attr_reader :name, :children, :parents

  def initialize(name)
    @name = name
    @parents = Set.new()
    @children = Set.new()
  end

  def add_parent(parent, constraint)
    @parents.add(parent)
    parent.children.add([constraint, self])
  end

  def eql?(other)
    other.name == self.name
  end

  def all_parents
    parents = Set.new(@parents)
    parents.merge(@parents.flat_map(&:all_parents)).to_a
  end

  def to_s
    @name
  end

  def inspect
    @name
  end

  def required_children_bag_counts
    @children.map do |constraint, child|
      constraint + constraint * child.required_children_bag_counts
    end.inject(:+) || 0
  end
end


scanned_rules = rules.scan(/\n?(?<parent_bag>[\w\s]+) bags contain (?<children_rule>.+)/)

bag_types = Set.new()

scanned_rules.each do |parent_bag_name, children_rule|
  parent = bag_types.find {|bt| bt.name == parent_bag_name}

  parent ||= BagType.new(parent_bag_name)
  bag_types.add(parent)



  children_rule.scan(/(?<constraint>\d+) (?<child_bag>[\w\s]+) bag/).each do |constraint, child_bag_name|
    child = bag_types.find {|bt| bt.name == child_bag_name}

    child ||= BagType.new(child_bag_name)
    bag_types.add(child)

    child.add_parent(parent, constraint.to_i)
  end
end

shiny_gold = bag_types.find {|bt| bt.name == "shiny gold"}

puts shiny_gold.required_children_bag_counts
instructions = File.readlines("input.txt").map do |line|
  line.match(/Step ([A-Z]) .+ ([A-Z])/)[1..2]
end

class Step < Struct.new(:name)
  def children
    (@children || []).sort_by(&:name)
  end

  def add_child(child_step)
    @children ||= []
    @children.push(child_step)
    child_step.add_parent(self)
  end

  def parents
    (@parents || []).sort_by(&:name)
  end

  def add_parent(parent_step)
    @parents ||= []
    @parents.push(parent_step)
  end

  def has_parents?
    parents.any?
  end

  def done!
    @done = true
  end

  def done?
    @done
  end

  def available_children
    children.reject { |child_step| child_step.parents.reject(&:done?).any? }
  end
end

steps = {}

instructions.each_with_index do |(a,b), idx|
  step_a = steps.fetch(a) { Step.new(a) }
  step_b = steps.fetch(b) { Step.new(b) }

  step_a.add_child(step_b)

  steps[a] = step_a
  steps[b] = step_b
end

available_children = steps.values.find_all {|step| !step.has_parents? }.sort_by(&:name)

step_order = ""

while available_children.any?
  current_step = available_children.shift
  current_step.done!
  step_order += current_step.name

  available_children += current_step.available_children

  available_children.reject!(&:done?)
  available_children.sort_by!(&:name)
  puts(available_children.map(&:name).join(" | "))

end

puts step_order

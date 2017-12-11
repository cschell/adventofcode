# needs `export RUBY_THREAD_VM_STACK_SIZE=5000000` to be set
input = File.read("input.txt")

instructions = input.split("")

class Collection
  def initialize(parent)
    @parent = parent
    @children = []
    @garbages = []
    @score = 0
  end

  def score
    @score
  end
end

class Garbage < Collection
  def parse_next_instruction(instructions)
    case instructions[0]
    when "!"
      parse_next_instruction(instructions[2..-1])
    when ">"
      @parent.parse_next_instruction(instructions[1..-1])
    else
      @score += 1
      parse_next_instruction(instructions[1..-1])
    end
  end
end

class Group < Collection
  def parse_next_instruction(instructions)
    case instructions[0]
    when "{"
      child = add_child
      child.parse_next_instruction(instructions[1..-1])
    when "}"
      @parent.parse_next_instruction(instructions[1..-1]) if @parent
    when "<"
      garbage = Garbage.new(self)
      @garbages += [garbage]
      garbage.parse_next_instruction(instructions[1..-1])
    when ","
      parse_next_instruction(instructions[1..-1])
    when nil
      return
    else
      raise "this should never happen, encountered %s" % [instructions[0]]
    end
  end

  def score
    parent_score = @parent ? @parent.score : 0
    parent_score + 1
  end

  def total_score
    score + @children.map(&:total_score).inject(0, &:+)
  end

  def add_child
    new_child = Group.new(self)
    @children += [new_child]
    new_child
  end

  def garbage_score
    (@garbages.map(&:score) + @children.map(&:garbage_score)).inject(0, &:+)
  end
end

root = Group.new(nil)
root.parse_next_instruction(instructions[1..-1])

puts "group score: %s" % root.total_score
puts "garbage score: %s" % root.garbage_score

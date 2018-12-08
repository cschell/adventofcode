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

  def lock!
    @locked = true
  end

  def locked?
    @locked
  end

  def available_children
    children.reject { |child_step| child_step.parents.reject(&:done?).any? }
  end

  def work_time
    (self[:name].upcase.ord - 'A'.ord) + 61
  end
end

steps = {}

instructions.each_with_index do |(a,b), idx|
  step_a = steps.fetch(a) { Step.new(a) }
  step_b = steps.fetch(b) { Step.new(b) }

  step_a.add_child(step_b)
  # puts("%s adding %s as child of %s" % [idx, step_b.name, step_a.name])

  steps[a] = step_a
  steps[b] = step_b
end

class Worker
  def initialize
    reset!
  end

  def tick!
    @time_until_finish -= 1
  end

  def start_working_on(step)
    @current_step = step
    @time_until_finish = step.work_time
    @current_step.lock!
  end

  def current_step
    @current_step
  end

  def available?
    @time_until_finish <= 0
  end

  def reset!
    @time_until_finish = 0
    @current_step = nil
  end

  def finished?
    @time_until_finish <= 0 && current_step
  end
end

available_steps = steps.values.find_all {|step| !step.has_parents? }.sort_by(&:name)

step_order = ""

workers = 5.times.map { Worker.new }

def collect_finished_steps(workers, available_steps)
  finished_workers = workers.find_all(&:finished?)
  finished_steps = finished_workers.map(&:current_step)
  finished_workers.each(&:reset!)
  finished_steps.each(&:done!)
  finished_steps
end

def update_available_steps(workers, available_steps, new_steps)
  available_steps += new_steps.flat_map(&:available_children)
  available_steps.uniq
                  .reject(&:locked?)
                  .sort_by(&:name)
end

def assign_steps(workers, available_steps)
  available_steps = available_steps.dup
  workers.find_all(&:available?).each do |worker|
    next_step = available_steps.shift
    break unless next_step
    worker.start_working_on(next_step)
  end

  available_steps
end

ticks = 0
while !steps.values.all?(&:done?) || !workers.all?(&:available?)
  workers.each(&:tick!)

  finished_steps = collect_finished_steps(workers, available_steps)
  finished_steps.sort_by!(&:name)
  finished_steps.each do |step|
    step_order += step.name
  end

  available_steps = update_available_steps(workers, available_steps, finished_steps)

  available_steps = assign_steps(workers, available_steps)

  puts "%3d | %s | %s | %s | %s | %s || %s" % [ticks, *workers.map(&:current_step).map {|s| s ? s.name : "-"}, step_order]
  ticks += 1

end

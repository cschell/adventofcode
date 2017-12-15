require "set"
input = File.read("input.txt")

class Program < Struct.new(:id, :connections)
  @@register = {}

  def connect_to(programs)
    single_connect_to(programs)
    programs.each do |prog|
      prog.single_connect_to([self])
    end
  end

  def single_connect_to(programs)
    self.connections ||= Set.new
    self.connections.merge(programs)
  end

  def group_count(already_counted = [])
    already_counted += [self]
    1 + (connections - already_counted).map { |prog| prog.group_count(already_counted)}.inject(0, &:+)
  end

  def all_group_programs(already_processed = [])
    already_processed += [self]
    [self] + (connections - already_processed).flat_map { |prog| prog.all_group_programs(already_processed)}
  end

  def self.connect_by_id(id, neighbour_ids)
    program = Program.find_or_create(id)

    connected_programs = neighbour_ids.map do |neighbour_id|
      Program.find_or_create(neighbour_id)
    end

    program.connect_to(connected_programs)
  end

  def self.find(id)
    @@register.fetch(id) { raise "didn't find #{id}"}
  end
  def self.find_or_create(id)
    prog = @@register.fetch(id) { Program.new(id) }
    Program.save(prog)
    prog
  end

  def self.save(program)
    @@register[program.id] = program
  end

  def self.register
    @@register
  end

  def self.count_groups
    all_ids = @@register.values.map(&:id)

    group_counter = 0
    while all_ids.count > 0
      if current_id = all_ids[0]
        current_group_ids = Program.find(current_id).all_group_programs.map(&:id)
        if current_group_ids.any?
          group_counter += 1
          all_ids -= current_group_ids
        end
      end
    end

    group_counter
  end
end

pipes = input.scan(/(\d+) <-> (.+)$/)

pipes.each do |pipe|
  raw_program_id, raw_connected_program_ids = pipe
  program_id = raw_program_id.to_i

  Program.connect_by_id(program_id, raw_connected_program_ids.split(", ").map(&:to_i))
end

puts Program.register[0].group_count
puts Program.count_groups

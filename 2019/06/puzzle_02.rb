orbits_definitions = File.readlines("input.txt", chomp: true).map {|definition| definition.split(")")}

ME = "YOU"
SANTA = "SAN"

class SpaceObject
  attr_accessor :parent
  attr_reader :name

  def initialize(name)
    @name = name
    @satellites = []
  end

  def add_satellite(satellite)
    satellite.parent = self
    @satellites << satellite
  end

  def orbit_count
    self.parents.length
  end

  def total_satellite_orbit_count
    @satellites.sum do |satellite|
      satellite.total_satellite_orbit_count
    end + self.orbit_count
  end

  def parents
    if self.parent
      [self.parent] + self.parent.parents
    else
      []
    end
  end

  def satellite_count
    @satellites.count
  end

  def to_s
    @name
  end
end

objects = {}

orbits_definitions.each do |object_a_name, object_b_name|
  object_a = objects.fetch(object_a_name) { SpaceObject.new(object_a_name) }
  object_b = objects.fetch(object_b_name) { SpaceObject.new(object_b_name) }

  object_a.add_satellite(object_b)

  objects[object_a_name] = object_a
  objects[object_b_name] = object_b
end

me_parents = objects[ME].parents.reverse
santa_parents = objects[SANTA].parents.reverse

connection_object = nil

objects.length.times do |idx|
  if me_parents[idx] != santa_parents[idx]
    puts me_parents.length - idx + santa_parents.length - idx
    break
  end
end

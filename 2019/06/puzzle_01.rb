orbits_definitions = File.readlines("input.txt", chomp: true).map {|definition| definition.split(")")}

class SpaceObject
  attr_accessor :parent

  def initialize()
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
end

objects = {}

orbits_definitions.each do |object_a_name, object_b_name|
  object_a = objects.fetch(object_a_name) { SpaceObject.new() }
  object_b = objects.fetch(object_b_name) { SpaceObject.new() }

  object_a.add_satellite(object_b)

  objects[object_a_name] = object_a
  objects[object_b_name] = object_b
end

centre_object = objects.values.find { |obj| obj.parent.nil? }

puts centre_object.total_satellite_orbit_count

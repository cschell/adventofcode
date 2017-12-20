require "matrix"

class Particle < Struct.new(:id, :position, :velocity, :acceleration)
  def step!
    return if destroyed?
    self.velocity += acceleration
    self.position += velocity
  end

  def destroy!
    @destroyed = true
  end

  def destroyed?
    @destroyed
  end

  def active?
    !destroyed?
  end
end

input = File.read("input.txt")
parsed_particle_instructions = input.scan(/p=\<(.+),(.+),(.+)>, v=<(.+),(.+),(.+)>, a=<(.+),(.+),(.+)>/)

particles = parsed_particle_instructions.each_with_index.map do |instruction, id|
  particle_x, particle_y, particle_z,
  particle_vel_x, particle_vel_y, particle_vel_z,
  particle_acc_x, particle_acc_y, particle_acc_z = instruction.map(&:to_i)

  position = Vector[particle_x, particle_y, particle_z]
  velocity = Vector[particle_vel_x, particle_vel_y, particle_vel_z]
  acceleration = Vector[particle_acc_x, particle_acc_y, particle_acc_z]

  Particle.new(id, position, velocity, acceleration)
end

# not being able to come up with a more elegant stopping criterium
# 100 rounds seems to be sufficient
100.times do
  particles.each(&:step!)

  particles.each do |particle|
    next if particle.destroyed?

    collided_particles = particles.select(&:active?)
                                  .find_all {|p| p.position == particle.position }

    if collided_particles.count >= 2
      collided_particles.each(&:destroy!)
    end
  end
end

puts particles.count(&:active?)

matches = File.read("input.txt").match(/(\d+) players.* (\d+) points/)

num_players, max_marble_points = matches[1..2].map(&:to_i)

class Elf
  def points
    @points || 0
  end

  def add_points(ps)
    @points ||= 0
    @points += ps
  end
end

class Marble < Struct.new(:points)
  attr_accessor :left, :right

  def add_right(new_marble)
    old_right = self.right
    self.right = new_marble
    new_marble.left = self
    new_marble.right = old_right
    old_right.left = new_marble
  end

  def get_left(num = 1)
    left_marble = self
    num.times do
      left_marble = left_marble.left
    end
    left_marble
  end

  def remove!
    left.right = right
    right.left = left
    self.left = nil
    self.right = nil
  end
end

elfs = num_players.times.map { Elf.new }

current_marble = Marble.new(0)
current_marble.left = current_marble
current_marble.right = current_marble

max_marble_points *= 100

(1..max_marble_points).each do |marble_idx|
  if marble_idx % 23 != 0
    new_marble = Marble.new(marble_idx)
    current_marble.right.add_right(new_marble)
    current_marble = new_marble
  else
    back_marble = current_marble.get_left(7)
    current_marble = back_marble.right
    back_marble.remove!
    current_elf = elfs.rotate(marble_idx).first
    current_elf.add_points(marble_idx)
    current_elf.add_points(back_marble.points)
  end
end

puts elfs.max_by(&:points).points

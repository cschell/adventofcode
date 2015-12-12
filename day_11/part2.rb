require "./part1"

class Part2 < Part1
  def result
    santas_password = SantaPassword.new(@old_password)
    2.times { santas_password.set_to_next_valid_password! }
    santas_password
  end
end

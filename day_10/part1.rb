require "pp"
class Part1
  def initialize(input)
    @start = input.first
    @iterations = 40
  end

  def result
    latest_sequence = @start.chomp.chars.map(&:to_i)

    @iterations.times do |i|
      new_sequence = Array.new

      latest_sequence.each do |number|
        last_number = new_sequence.last
        if last_number && last_number[1] == number
          last_number[0] += 1
        else
          new_sequence.push([1, number])
        end
      end

      latest_sequence = new_sequence.flatten
    end

    latest_sequence.count
  end
end

require "pp"
class Part1
  def initialize(input)
    @strings = input
  end

  def result
    raw_chars_count = 0
    memory_chars_count = 0

    @strings.each do |string|
      raw_chars_count += string.chomp.size
      memory_chars_count += eval(string.chomp).size
    end

    raw_chars_count - memory_chars_count
  end
end

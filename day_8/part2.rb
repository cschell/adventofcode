require "pp"
class Part2
  def initialize(input)
    @strings = input
  end

  def result
    raw_chars_count = 0
    encoded_chars_count = 0

    @strings.each do |string|
      raw_chars_count += string.chomp.size
      encoded_chars_count += string.gsub('\\', '\\\\\\').gsub('"', '\\"').chomp.size + (add_double_quotes = 2)
    end

    encoded_chars_count - raw_chars_count
  end
end

require "json"
require "./part1"

class Part2
  def initialize(input)
    @data = JSON.parse(input.first)
  end

  def result
    sanitize(@data).to_json.scan(/-?\d+/).map(&:to_i).inject(&:+)
  end

  def sanitize(element)
    case element
    when Array
      element.map do |child|
        sanitize(child)
      end
    when Hash
      unless element.values.include?("red")
        element.map do |child|
          sanitize(child)
        end
      end
    else
      element
    end
  end
end

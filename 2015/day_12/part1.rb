class Part1
  def initialize(input)
    @data = input.first.chomp
  end

  def result
    @data.scan(/-?\d+/).map(&:to_i).inject(&:+)
  end
end

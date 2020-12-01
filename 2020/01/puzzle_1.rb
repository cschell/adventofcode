numbers = File.readlines("input.txt").map(&:to_i)


numbers.filter {|n| n <= 1000}.each do |n1|
  numbers.filter {|n| n > 1000}.each do |n2|
    puts(n1 * n2) if (n1 + n2) == 2020
  end
end

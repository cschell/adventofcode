numbers = File.readlines("input.txt").map(&:to_i)


numbers.filter {|n| n <= 1000}.each do |n1|
  numbers.filter {|n| n <= 1000}.each do |n2|
    numbers.filter {|n| n > 1000}.each do |n3|
      puts(n1 * n2 * n3) if (n1 + n2 + n3) == 2020
    end
  end
end

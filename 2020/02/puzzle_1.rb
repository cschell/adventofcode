lines = File.readlines("input.txt")

password_combinations = lines.map {|line| /(?<number_1>\d+)-(?<number_2>\d+) (?<letter>\w): (?<password>\w+)/.match(line)}


counter = 0
password_combinations.each do |comb|
  occurrences = comb[:password].count(comb[:letter])

  n1 = comb[:number_1].to_i
  n2 = comb[:number_2].to_i
  if (n1..n2).include?(occurrences)
    counter += 1
  end
end

puts counter

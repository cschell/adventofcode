lines = File.readlines("input.txt")

password_combinations = lines.map {|line| /(?<number_1>\d+)-(?<number_2>\d+) (?<letter>\w): (?<password>\w+)/.match(line)}


counter = 0
password_combinations.each do |comb|
  n1 = comb[:number_1].to_i - 1
  n2 = comb[:number_2].to_i - 1

  if (comb[:password][n1] == comb[:letter] && comb[:password][n2] != comb[:letter]) ||
     (comb[:password][n1] != comb[:letter] && comb[:password][n2] == comb[:letter])
     counter += 1
  end
end

puts counter

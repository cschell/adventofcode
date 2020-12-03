rows = File.readlines("input.txt", chomp: true)

num_columns = rows[0].length

current_column = 0

tree_counter = 0

rows.each do |row|
  if current_column >= num_columns
    current_column -= num_columns
  end

  if row[current_column] == "#"
    tree_counter += 1
  end
  current_column += 3
end

puts tree_counter

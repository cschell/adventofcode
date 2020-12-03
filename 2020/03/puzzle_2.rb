rows = File.readlines("input.txt", chomp: true)

num_columns = rows[0].length

multiplied_tree_counter = 1

instructions = [
  {right: 1, down: 1},
  {right: 3, down: 1},
  {right: 5, down: 1},
  {right: 7, down: 1},
  {right: 1, down: 2},
]

instructions.each do |instruction|
  current_column = 0

  current_tree_counter = 0

  rows.each_with_index do |row, idx|
    if idx % instruction[:down] != 0
      next
    end

    if current_column >= num_columns
      current_column -= num_columns
    end

    if row[current_column] == "#"
      current_tree_counter += 1
    end
    current_column += instruction[:right]
  end

  multiplied_tree_counter *= current_tree_counter
end

# 916 too low

puts multiplied_tree_counter

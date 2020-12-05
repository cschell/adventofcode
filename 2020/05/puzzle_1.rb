boarding_passes = File.readlines("input.txt").map(&:chomp)

@seat_ids = []

boarding_passes.each do |bp_number|
  row_instructions = bp_number[0..6]
  col_instructions = bp_number[7..-1]

  rows = (0..127).to_a

  row_instructions.each_char do |inst|
    subsections = rows.each_slice(rows.length / 2).to_a

    rows = if inst == "F"
              subsections.first
           elsif inst == "B"
              subsections.last
           end
  end

  raise "too many rows" if rows.length != 1
  row = rows.first


  cols = (0..7).to_a

  col_instructions.each_char do |inst|
    subsections = cols.each_slice(cols.length / 2).to_a

    cols = if inst == "L"
              subsections.first
           elsif inst == "R"
              subsections.last
           end
  end

  raise "too many cols" if cols.length != 1
  col = cols.first

  @seat_ids << 8 * row + col
end

puts "puzzle_1 result: #{@seat_ids.max}"
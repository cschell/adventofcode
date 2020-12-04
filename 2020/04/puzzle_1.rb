batch = File.read("input.txt")

formatted = batch.gsub("\n\n", ";")
                 .gsub("\n", ",")
                 .gsub(" ", ",")
                 .gsub(";","\n")


required_fields = [
                    "byr", # Birth Year
                    "iyr", # Issue Year
                    "eyr", # Expiration Year
                    "hgt", # Height
                    "hcl", # Hair Color
                    "ecl", # Eye Color
                    "pid", # Passport ID
                    #"cid", # Country ID
                  ].sort

valid_count = 0

formatted.each_line do |line|
  passport = Hash[line.chomp.split(",").map {|field| field.split(":")}]

  if (required_fields - passport.keys.sort).empty?
    valid_count += 1
  end
end

puts valid_count


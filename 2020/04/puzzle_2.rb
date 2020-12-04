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

valid_eye_colors = [
  "amb", "blu", "brn", "gry", "grn", "hzl", "oth"
]

def valid_height?(height)
  case height
  when /(\d+)cm$/
    return (150..193).include?($1.to_i)
  when /(\d+)in$/
    return (59..76).include?($1.to_i)
  else
    return false
  end
end

valid_count = 0

formatted.each_line do |line|
  passport = Hash[line.chomp.split(",").map {|field| field.split(":")}]

  if (required_fields - passport.keys.sort).empty?  \
       && (1920..2002).include?(passport["byr"].to_i) \
       && (2010..2020).include?(passport["iyr"].to_i) \
       && (2020..2030).include?(passport["eyr"].to_i) \
       && valid_height?(passport["hgt"]) \
       && passport["hcl"] =~ /#[0-9a-fA-F]{6}/ \
       && valid_eye_colors.include?(passport["ecl"]) \
       && passport["pid"] =~ /^\d{9}$/
    valid_count += 1
  end
end

puts valid_count


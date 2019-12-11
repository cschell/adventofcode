pixels = File.read("input.txt").chomp.split("").map(&:to_i)

layers = pixels.each_slice(25*6)

image = Array.new(25*6)

layers.each do |layer|
  layer.each_with_index do |pixel, idx|
    if image[idx].nil? && pixel != 2
      image[idx] = pixel
    end
  end
end

image.each_slice(25).each {|row| row.each {|pixel| print(pixel == 0 ? " " : "X") }; puts "" }

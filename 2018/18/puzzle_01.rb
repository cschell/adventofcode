require "matrix"

input_lines = File.readlines("input.txt").map(&:chomp).reject(&:empty?)

class Parcel
  attr_accessor :row_idx, :column_idx
end

class OpenGround < Parcel
  def to_s
    "."
  end
end

class Tree < Parcel
  def to_s
    "|"
  end
end

class Lumberyard < Parcel
  def to_s
    "#"
  end
end

class LumberCollectionArea < Matrix
  public :"[]=", :set_element, :set_component

  def set(row_idx, column_idx, parcel)
    self[row_idx, column_idx] = parcel
    parcel.row_idx = row_idx
    parcel.column_idx = column_idx
  end

  def to_s
    to_a.map do |parcel_row|
      parcel_row.map(&:to_s).join
    end.join("\n")
  end

  def step!
    new_area = self.dup
    each_with_index do |parcel, row_idx, column_idx|
      neighbour_coordinates = [
        [row_idx - 1, column_idx - 1],
        [row_idx    , column_idx - 1],
        [row_idx - 1, column_idx    ],
        [row_idx + 1, column_idx + 1],
        [row_idx    , column_idx + 1],
        [row_idx + 1, column_idx    ],
        [row_idx + 1, column_idx - 1],
        [row_idx - 1, column_idx + 1],
      ].reject { |coord| coord.any? {|c| c < 0} }

      if parcel.is_a?(OpenGround) && neighbour_coordinates.count { |coord| self[*coord].is_a?(Tree)} >= 3
        new_area.set(row_idx, column_idx, Tree.new)
      elsif parcel.is_a?(Tree) && neighbour_coordinates.count { |coord| self[*coord].is_a?(Lumberyard)} >= 3
        new_area.set(row_idx, column_idx, Lumberyard.new)
      elsif parcel.is_a?(Lumberyard) &&
                  neighbour_coordinates.count { |coord| self[*coord].is_a?(Tree)} == 0 ||
                  neighbour_coordinates.count { |coord| self[*coord].is_a?(Lumberyard)} == 0
        new_area.set(row_idx, column_idx, OpenGround.new)
      end
    end
    new_area.each_with_index do |new_parcel, row_idx, column_idx|
      self[row_idx, column_idx] = new_parcel
    end
  end

end

lca = LumberCollectionArea.zero(input_lines.count, input_lines.first.length)

input_lines.each_with_index do |line, row_idx|
  line.split("").each_with_index do |symbol, column_idx|
    parcel = case symbol
             when "."
               OpenGround.new
             when "|"
               Tree.new
             when "#"
               Lumberyard.new
             end

    lca.set(row_idx, column_idx, parcel)
  end
end


num_tree_parcels = lca.to_a.flatten.count { |parcel| parcel.is_a?(Tree) }
num_lumberyard_parcels = lca.to_a.flatten.count { |parcel| parcel.is_a?(Lumberyard) }

puts num_tree_parcels * num_lumberyard_parcels

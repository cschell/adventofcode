input = 312_051

class Cell < Struct.new(:id, :parent)
  attr_accessor :child

  @neighbors = []

  def initialize(*attrs)
    super(*attrs)
    parent.child = self if parent
  end

  def sub_ring_partner
    if @sub_ring_partner
      return @sub_ring_partner
    end

    corner = if row_index == 0
              1
            else
              0
            end

    steps_to_go_back = current_ring_cell_count - (4 - edge_number) * 2 - corner + 1

    sub_ring_partner_id = id - steps_to_go_back

    if ring_index == 0
      sub_ring_partner_id += 1
    end

    @sub_ring_partner = find_cell(sub_ring_partner_id)

    @sub_ring_partner
  end

  def sub_ring_neighbours
    if row_index == 0 && edge_number == 4
      [sub_ring_partner, sub_ring_partner.child]
    elsif row_index == max_row_index && max_row_index == 1 && edge_number < 3
      [sub_ring_partner]
    elsif row_index == 0
      [sub_ring_partner]
    elsif ring_index == 0
      [sub_ring_partner]
    elsif ring_index == 1
      [sub_ring_partner, sub_ring_partner.child]
    elsif row_index == 1
      [sub_ring_partner, sub_ring_partner.child]
    elsif row_index == max_row_index && edge_number != 3
      [sub_ring_partner, sub_ring_partner.parent]
    else
      [sub_ring_partner, sub_ring_partner.parent, sub_ring_partner.child]
    end.compact - [self]
  end

  def ring_neighbour_indices
    if row_index == 1 && ring_index != 0 || ring_index == 1
      [id - 1, id - 2]
    else
      [id - 1]
    end
  end

  def ring_neighbours
    find_cells(ring_neighbour_indices)
  end

  def neighbours
    (sub_ring_neighbours + ring_neighbours).uniq
  end

  def neighbour_indices
    (ring_neighbour_indices + sub_ring_neighbour_indices).uniq
  end

  def value
    @value ||= neighbours.map(&:value).inject(0, &:+)
  end

  def find_cell(searched_index)
    if id == searched_index
      self
    elsif !parent
      nil
    else
      parent.find_cell(searched_index)
    end
  end

  def find_cells(searched_indices)
    searched_indices.flat_map do |searched_index|
      find_cell(searched_index)
    end.compact.uniq
  end

  def max_row_index
    ring_number * 2 - 1
  end

  def row_index
    @row_index ||= if parent.ring_number != ring_number
      1
    elsif parent.row_index >= max_row_index
      0
    else
      parent.row_index + 1
    end
  end

  def ring_index
    @ring_index ||= if parent.ring_number != ring_number
      0
    else
      parent.ring_index + 1
    end
  end

  def ring_number
    if @ring_number
      return @ring_number
    end
    next_sqrt = Math.sqrt(id).ceil
    rings_bottom_right_corner_value = if next_sqrt % 2 == 0
                                        (next_sqrt + 1) ** 2
                                      else
                                        next_sqrt ** 2
                                      end

    @ring_number = (Math.sqrt(rings_bottom_right_corner_value) / 2).floor
  end

  def edge_number
    @edge_number ||= if ring_index == 0
      0
    elsif row_index == 0
      parent.edge_number + 1
    else
      parent.edge_number
    end
  end

  def current_ring_cell_count
    ring_number * 8
  end

  def previous_ring_cell_count
    (ring_number - 1 + 2) ** 2
  end
end

class FirstCell < Cell
  def value
    1
  end
end

last_cell = FirstCell.new(1)

loop do
  last_cell = Cell.new(last_cell.id + 1, last_cell)
  if last_cell.value > input
    puts(last_cell.value)
    break
  end
end


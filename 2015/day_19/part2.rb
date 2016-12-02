require "./part1"

class Part2 < Part1

  def result
    @replacements = @instructions.map do |instruction|
      instruction.scan(/(\w+) => (\w+)/).flatten.reverse
    end

    @intermediate_molecules = []
    @smallest_depth = Float::INFINITY
    puts  "%-16s %-16s %-16s \r" % ["fewest steps yet", "current steps", "current molecule size"]
    search_for_quickest_way_to_e(@molecule)
    @smallest_depth
  end

  def search_for_quickest_way_to_e(molecule, depth = 0)
    if @smallest_depth <= depth
      return
    elsif molecule == "e"
      @smallest_depth = depth
      return
    end

    print "%-16s %-16s %-16s \r" % [@smallest_depth, depth, molecule.size]

    @replacements.each do |replacement|
      current_index = -1
      while current_index = molecule.index(replacement[0], current_index + 1)
        new_molecule = molecule.clone
        new_molecule[current_index, replacement[0].size] = replacement[1]
        unless @intermediate_molecules.include?([new_molecule, depth + 1])
          @intermediate_molecules << [new_molecule, depth + 1]
          search_for_quickest_way_to_e(new_molecule, depth + 1)
        end
      end
    end
  end
end

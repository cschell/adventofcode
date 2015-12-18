class Part1
  def initialize(input)
    @instructions = input
  end

  def result
    @ingredients = @instructions.map do |instruction|
      if instruction =~ /capacity ([\d-]+), durability ([\d-]+), flavor ([\d-]+), texture ([\d-]+), calories ([\d-]+)/
        Ingredient.new(*[$1, $2, $3, $4, $5].map(&:to_i))
      end
    end


    counters = Array.new(@ingredients.count, 0)
    scores = []
    (100 ** @ingredients.count).times do |count|
      counters.each_with_index do |counter, index|
        if counter >= 100
          counters[index] = 0
        else
          counters[index] += 1
          break
        end
      end

      if counters.inject(&:+) == 100
        recipe_ingredients = []
        counters.each_with_index do |counter, index|
          recipe_ingredients += [@ingredients[index]] * counter
        end
        scores << Recipe.new(recipe_ingredients).score
      end
    end
    scores.max
  end

end

class Ingredient < Struct.new(:capacity, :durability, :flavor, :texture, :calories)
end

class Recipe
  INGREDIENT_PROPERTIES = [:capacity, :durability, :flavor, :texture]

  def initialize(ingredients)
    raise ArgumentError if ingredients.count != 100
    @ingredients = ingredients
  end

  def score
    INGREDIENT_PROPERTIES.map do |property|
      [@ingredients.map { |g| g.send(property) }.inject(&:+), 0].max
    end.inject(&:*)
  end
end

require "./part1"

class Part2 < Part1
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
        recipe = Recipe.new(recipe_ingredients)
        scores << recipe.score if recipe.calories == 500
      end
    end
    scores.max
  end
end

class Recipe
  def calories
    @ingredients.map(&:calories).inject(&:+)
  end
end

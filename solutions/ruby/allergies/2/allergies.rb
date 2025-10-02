class Allergies
  ALLERGENS = %w[eggs peanuts shellfish strawberries tomatoes chocolate pollen cats]
  
  def initialize(score)
    @score = score
  end

  def allergic_to?(allergen)
    allergen_index = ALLERGENS.index(allergen)

    raise ArgumentError unless allergen_index

    allergic_to_index?(allergen_index)
  end

  def list
    ALLERGENS.values_at(*(0...ALLERGENS.length).select(&method(:allergic_to_index?)))
  end

  private

  def allergic_to_index?(index)
    @score & (1 << index) != 0
  end
end

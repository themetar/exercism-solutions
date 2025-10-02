require_relative 'solver'

module ZebraPuzzle

  CATEGORIES = {
    colors: %i[red green ivory yellow blue],
    nationalities: %i[English Spanish Ukranian Japanese Norwegian],
    pets: %i[dog snail fox horse zebra],
    beverages: %i[water coffee tea milk juice],
    hobbies: %i[dancing painting reading football chess]
  }.freeze

  SAME_HOUSE = ->(category_a, value_a, category_b, value_b) { category_a[category_b.index(value_b)] == value_a }

  AT_HOUSE = ->(category, value, index) { category[index] == value }

  NEXT_TO = ->(category_a, value_a, category_b, value_b) { (category_a.index(value_a) - category_b.index(value_b)).abs == 1 }

  # 1. There are five houses. // this is implicit
  RULES = [
    # 2. The Englishman lives in the red house.
    ->(nationalities, colors) { SAME_HOUSE.call(nationalities, :English, colors, :red) },
    # 3. The Spaniard owns the dog.
    ->(nationalities, pets) { SAME_HOUSE.call(nationalities, :Spanish, pets, :dog) },
    # 4. The person in the green house drinks coffee.
    ->(beverages, colors) { SAME_HOUSE.call(beverages, :coffee, colors, :green) },
    # 5. The Ukrainian drinks tea.
    ->(beverages, nationalities) { SAME_HOUSE.call(beverages, :tea, nationalities, :Ukranian) },
    # 6. The green house is immediately to the right of the ivory house.
    ->(colors) { AT_HOUSE.call(colors, :green, colors.index(:ivory) + 1) },
    # 7. The snail owner likes to go dancing.
    ->(pets, hobbies) { SAME_HOUSE.call(pets, :snail, hobbies, :dancing) },
    # 8. The person in the yellow house is a painter.
    ->(colors, hobbies) { SAME_HOUSE.call(colors, :yellow, hobbies, :painting) },
    # 9. The person in the middle house drinks milk.
    ->(beverages) { AT_HOUSE.call(beverages, :milk, 2) },
    # 10. The Norwegian lives in the first house.
    ->(nationalities) { AT_HOUSE.call(nationalities, :Norwegian, 0) },
    # 11. The person who enjoys reading lives in the house next to the person with the fox.
    ->(hobbies, pets) { NEXT_TO.call(hobbies, :reading, pets, :fox) },
    # 12. The painter's house is next to the house with the horse.
    ->(hobbies, pets) { NEXT_TO.call(hobbies, :painting, pets, :horse) },
    # 13. The person who plays football drinks orange juice.
    ->(hobbies, beverages) { SAME_HOUSE.call(hobbies, :football, beverages, :juice) },
    # 14. The Japanese person plays chess.
    ->(nationalities, hobbies) { SAME_HOUSE.call(nationalities, :Japanese, hobbies, :chess) },
    # 15. The Norwegian lives next to the blue house.
    ->(nationalities, colors) { NEXT_TO.call(nationalities, :Norwegian, colors, :blue) }
  ].freeze

  HOUSES = Solver.new(CATEGORIES, RULES).solution.freeze

  def self.water_drinker
    drinks_water = HOUSES[:beverages].index(:water)
    HOUSES.dig(:nationalities, drinks_water).to_s
  end

  def self.zebra_owner
    owns_zebra = HOUSES[:pets].index(:zebra)
    HOUSES.dig(:nationalities, owns_zebra).to_s
  end

end

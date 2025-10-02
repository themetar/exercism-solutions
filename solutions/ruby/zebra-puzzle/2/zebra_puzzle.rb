class Solver
  # Solver requires a problem domain hash and a rules array
  #
  #   Domain: { category: [ possible values ... ], ... }
  #   Rules: [ lambda, lambda, ... ]
  #
  # Rule lambdas must return true or false. Their parameters must be named after
  # the categories (colors, nationalities, etc.) they relate to.
  # Each parameter will be assigned with an ordering of its category to test.

  def solution
    return @solution if @solution

    catch :done  do
      nested({}, categories)
    end

    @solution
  end

  private

  attr_accessor :problem_domain, :categories, :rules_per_category

  def initialize(problem_domain, rules)
    self.problem_domain = problem_domain
    self.categories = problem_domain.keys
    self.rules_per_category = categories.to_enum(:to_h).with_index do |category, i|
      [
        category,
        rules.filter do |rule|
          params(rule).then { |tags| tags.include?(category) && (tags - categories[..i]).empty? }
        end
      ]
    end
  end

  def params(proc)
    proc.parameters.map { |_, name| name }
  end

  def test_rule(proc, data)
    proc.call(*params(proc).map(&data))
  end

  def nested(partial, remaining)
    if remaining.empty? # success
      @solution = partial
      throw :done
    end

    category, *rest = remaining

    problem_domain[category].permutation do |ordering|
      partial = partial.merge({ category => ordering })

      next unless rules_per_category[category].all? { |rule| test_rule(rule, partial) }

      nested(partial, rest)
    end
  end
end

module ZebraPuzzle
  CATEGORIES = {
    colors: %i[red green ivory yellow blue],
    nationalities: %i[English Spanish Ukranian Japanese Norwegian],
    pets: %i[dog snail fox horse zebra],
    beverages: %i[water coffee tea milk juice],
    hobbies: %i[dancing painting reading football chess]
  }.freeze

  # 1. There are five houses. // this is implicit
  RULES = [
    # 2. The Englishman lives in the red house.
    ->(nationalities, colors) { nationalities.index(:English) == colors.index(:red) },
    # 3. The Spaniard owns the dog.
    ->(nationalities, pets) { pets[nationalities.index(:Spanish)] == :dog },
    # 4. The person in the green house drinks coffee.
    ->(beverages, colors) { beverages.index(:coffee) == colors.index(:green) },
    # 5. The Ukrainian drinks tea.
    ->(beverages, nationalities) { beverages.index(:tea) == nationalities.index(:Ukranian) },
    # 6. The green house is immediately to the right of the ivory house.
    ->(colors) { colors.index(:green) == colors.index(:ivory) + 1 },
    # 7. The snail owner likes to go dancing.
    ->(pets, hobbies) { hobbies[pets.index(:snail)] == :dancing },
    # 8. The person in the yellow house is a painter.
    ->(colors, hobbies) { hobbies[colors.index(:yellow)] == :painting },
    # 9. The person in the middle house drinks milk.
    ->(beverages) { beverages.index(:milk) == 2 },
    # 10. The Norwegian lives in the first house.
    ->(nationalities) { nationalities.first == :Norwegian },
    # 11. The person who enjoys reading lives in the house next to the person with the fox.
    ->(hobbies, pets) { (hobbies.index(:reading) - pets.index(:fox)).abs == 1 },
    # 12. The painter's house is next to the house with the horse.
    ->(hobbies, pets) { (hobbies.index(:painting) - pets.index(:horse)).abs == 1 },
    # 13. The person who plays football drinks orange juice.
    ->(hobbies, beverages) { beverages[hobbies.index(:football)] == :juice },
    # 14. The Japanese person plays chess.
    ->(nationalities, hobbies) { hobbies[nationalities.index(:Japanese)] == :chess },
    # 15. The Norwegian lives next to the blue house.
    ->(nationalities, colors) { (nationalities.index(:Norwegian) - colors.index(:blue)).abs == 1 }
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

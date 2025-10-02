class DndCharacter

  ABILITIES = %i[
    strength
    dexterity
    constitution
    intelligence
    wisdom
    charisma
  ]

  BASE_HITPOINTS = 10

  MODIFIER = ->(value) { value/2 - 5 }

  def self.modifier(value)
    MODIFIER[value]
  end

  private

  attr_writer :hitpoints, *ABILITIES

  def initialize
    ABILITIES.each do |ability|
      send("#{ability}=", Die.new.roll(4, take_highest: 3).sum)
    end
    self.hitpoints = BASE_HITPOINTS + MODIFIER[constitution]
  end

  public

  attr_reader :hitpoints, *ABILITIES

end

class Die

  private

  attr_writer :sides

  def initialize(sides = 6)
    self.sides = sides
  end

  public

  attr_reader :sides

  def roll(count = 1, take_highest: count)
    count.times.map { rand(1..sides) }.max(take_highest)
  end
end

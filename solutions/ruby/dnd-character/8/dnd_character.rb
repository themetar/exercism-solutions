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

  def self.modifier(value)
    value/2 - 5
  end

  private

  attr_writer :hitpoints

  ABILITIES.each do |ability|
    attr_writer ability
  end

  def initialize
    ABILITIES.each do |ability|
      self.send("#{ability}=", Die.new.roll(4, take_highest: 3).sum)
    end
    self.hitpoints = BASE_HITPOINTS + self.class.modifier(constitution)
  end

  public

  attr_reader :hitpoints

  ABILITIES.each do |ability|
    attr_reader ability
  end

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
    count.times.map { rand(1..sides) } .max(take_highest)
  end
end

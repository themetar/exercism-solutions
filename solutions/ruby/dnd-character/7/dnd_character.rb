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
    value/2  - 5
  end

  private

  attr_writer :hitpoints

  ABILITIES.each do |ability|
    attr_writer ability
  end

  def initialize
    ABILITIES.each do |ability|
      self.send("#{ability}=", Die.new.sum_roll(4, drop_lowest: 1))
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

  def roll(count = 1)
    count.times.map { rand(1..sides) }
  end

  def sum_roll(count = 1, drop_lowest: 0)
    roll(count).sort.drop(drop_lowest).sum
  end
end
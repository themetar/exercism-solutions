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
    (value - 10) / 2
  end

  private

  ABILITIES.each do |ability|
    attr_writer ability
  end

  def initialize
    die = Die.new(6)
    ABILITIES.each do |ability|
      self.send("#{ability}=", die.roll(4).sort.drop(1).sum)
    end
    self.hitpoints = BASE_HITPOINTS + self.class.modifier(constitution)
  end

  public

  attr_accessor :hitpoints
  
  ABILITIES.each do |ability|
    attr_reader ability
  end

end

class Die
  
  class DieSideError < ArgumentError
    
    def initialize(message = 'Sides must be greater than 1')
      super message
    end
  
  end
  
  private

  attr_writer :sides

  def initialize(sides)
    raise DieSideError if sides < 2

    self.sides = sides
  end

  public

  attr_reader :sides

  def roll(count = nil)
    return rand(1..sides) unless count

    count.times.map { roll }
  end

end
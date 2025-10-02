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
    ABILITIES.each do |ability|
      self.send("#{ability}=", Die.new.roll(4).sort.drop(1).sum)
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
      super
    end
  
  end
  
  private

  attr_writer :sides

  def initialize(sides = 6)
    raise DieSideError if sides < 2

    self.sides = sides
  end

  public

  attr_reader :sides

  def roll(count = nil)
    return rand(1..sides) unless count

    count.times.map { rand(1..sides) }
  end

end
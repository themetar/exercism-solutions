class DndCharacter
  ABILITIES = %i[strength dexterity constitution intelligence wisdom charisma]
  BASE_HITPOINTS = 10
  
  def self.modifier(value)
    ((value - 10) / 2.0).floor
  end

  def initialize
    @abilities = ABILITIES.each_with_object({}) do |ability, h|
      h[ability] = 4.times
                      .map { 1 + rand(6) }
                      .sort
                      .drop(1)
                      .sum
    end
  end

  ABILITIES.each do |ability|
    define_method(ability) do
      @abilities[ability]
    end
  end

  def hitpoints
    BASE_HITPOINTS + self.class.modifier(constitution)
  end
end

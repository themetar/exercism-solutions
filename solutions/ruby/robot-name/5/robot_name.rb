class Robot

  NAMES = ("AA000".."ZZ999").to_a.shuffle

  @name_index = 0

  def self.next_name
    NAMES[(@name_index += 1) % NAMES.length]
  end

  def self.forget; end

  attr_reader :name

  def initialize
    @name = self.class.next_name
  end

  def reset
    initialize
  end

end

class Darts

  SCORING = { 1 => 10, 25 => 5, 100 => 1, Float::INFINITY => 0 }

  attr_reader :score

  def initialize(x, y)
    distance_squared = x**2 + y**2
    _, @score = SCORING.find { |radius, _| distance_squared <= radius }
  end

end

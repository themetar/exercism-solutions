class Darts
  attr_reader :score
  
  def initialize(x, y)
    dist = Math.sqrt(x**2 + y**2)
    @score = dist <= 1 ? 10 : dist <= 5 ? 5 : dist <= 10 ? 1 : 0
  end
end

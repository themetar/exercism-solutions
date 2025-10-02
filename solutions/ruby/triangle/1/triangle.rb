class Triangle
  def initialize(sides)
    @sides = sides
  end

  def equilateral?
    valid? && @sides.all?(@sides[0])
  end

  def isosceles?
    valid? && 3.times.any? { |i| @sides[i] == @sides[i-1] }
  end

  def scalene?
    valid? && !isosceles?
  end
    
  def valid?
    @valid.nil? ? @valid = 3.times.all? { |i| @sides[i] > 0 && @sides[i] <= @sides[i-1] + @sides[i-2] } : @valid
  end
end
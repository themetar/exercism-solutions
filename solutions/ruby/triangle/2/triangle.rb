class Triangle
  def initialize(sides)
    @sides = sides
  end

  def equilateral?
    valid? && @sides.all?(@sides.first)
  end

  def isosceles?
    valid? && @sides.combination(2).any? { |a, b| a == b }
  end

  def scalene?
    valid? && !isosceles?
  end
    
  def valid?
    if @valid.nil?
      @valid = @sides.permutation.all? { |a, b, c| a > 0 && a <= b + c }
    end
    @valid
  end
end
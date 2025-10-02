class Series
  def initialize(string)
    raise ArgumentError if /[^\d]/ =~ string
    
    @digits = string.each_char.map(&:to_i)
  end

  def largest_product(span)
    raise ArgumentError if span > @digits.length || span < 0
    
    @digits.each_cons(span).map { |cons| cons.reduce(1, &:*) }.max
  end
end

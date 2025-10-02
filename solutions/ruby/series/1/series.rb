class Series
  def initialize(string)
    @string = string
  end

  def slices(n)
    raise ArgumentError.new if n < 0
    raise ArgumentError.new if n > string.length

    0.upto(string.length - n).map { |i| string[i, n] }
  end

  private

  attr_reader :string
end

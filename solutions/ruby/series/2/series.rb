class Series
  def initialize(string)
    @string = string
  end

  def slices(n)
    raise ArgumentError.new if !(0..string.length).cover?(n)

    string.each_char.each_cons(n).map(&:join)
  end

  private

  attr_reader :string
end

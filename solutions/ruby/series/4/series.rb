class Series
  def initialize(string)
    raise ArgumentError if string.empty?
    @string = string
  end

  def slices(n)
    raise ArgumentError unless (1..string.length).cover?(n)

    string.each_char.each_cons(n).map(&:join)
  end

  private

  attr_reader :string
end

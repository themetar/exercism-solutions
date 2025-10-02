class Hamming
  def self.compute(string_a, string_b)
    raise ArgumentError.new if string_a.length != string_b.length

    string_a.split('').zip(string_b.split('')).inject(0) do |acc, item|
      a, b = item
      acc + (a != b ? 1 : 0)
    end
  end
end

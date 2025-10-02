class Hamming
  def self.compute(string_a, string_b)
    raise ArgumentError.new if string_a.length != string_b.length

    (0...string_a.length).inject(0) do |acc, i|
      a, b = string_a[i], string_b[i]
      acc + (a != b ? 1 : 0)
    end
  end
end

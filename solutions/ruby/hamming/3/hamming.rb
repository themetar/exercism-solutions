class Hamming
  def self.compute(string_a, string_b)
    raise ArgumentError.new if string_a.length != string_b.length

    (0...string_a.length).count { |i| string_a[i] != string_b[i] }
  end
end

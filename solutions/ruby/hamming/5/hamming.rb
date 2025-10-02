module Hamming
  def self.compute(string_a, string_b)
    raise ArgumentError if string_a.length != string_b.length

    string_a.each_char
      .to_enum(:zip, string_b.each_char)
      .count { |char_a, char_b| char_a != char_b }
  end
end

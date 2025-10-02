class Nucleotide
  attr_reader :histogram

  def initialize(string)
    raise ArgumentError unless /^[GTCA]*$/ === string
    
    @histogram = string.chars.tally({'G' => 0, 'T' => 0, 'C' => 0, 'A' => 0})
  end

  def count(nucleotide)
    histogram[nucleotide]
  end

  def self.from_dna(string)
    Nucleotide.new(string)
  end
end

module Complement
  SWAP = {'G' => 'C',
          'C' => 'G',
          'T' => 'A',
          'A' => 'U'}

  def self.of_dna(sequence)
    sequence.gsub(/./) { |nuc| SWAP[nuc] }
  end
end

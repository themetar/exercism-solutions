class InvalidCodonError < StandardError; end

module Translation
  MAPPING = {
    'AUG' => 'Methionine',
    'UUU' => 'Phenylalanine',
    'UUC' => 'Phenylalanine',
    'UUA'  => 'Leucine',
    'UUG' => 'Leucine',
    'UCU' => 'Serine',
    'UCC' => 'Serine',
    'UCA' => 'Serine',
    'UCG' => 'Serine',
    'UAU' => 'Tyrosine',
    'UAC' => 'Tyrosine',
    'UGU' => 'Cysteine',
    'UGC' => 'Cysteine',
    'UGG' => 'Tryptophan',
    'UAA' => :STOP,
    'UAG' => :STOP,
    'UGA' => :STOP
  }
  
  def self.of_rna(strand)
    strand.each_char.each_slice(3).map(&:join)
      .each_with_object([]) do |codon, proteins|
        raise InvalidCodonError unless MAPPING[codon]
  
        break proteins if MAPPING[codon] == :STOP
  
        proteins << MAPPING[codon]
    end
  end
end

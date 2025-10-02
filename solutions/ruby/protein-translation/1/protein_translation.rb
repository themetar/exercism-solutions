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
    strand.each_char.each_slice(3).with_object([]) do |codon, proteins|
      raise InvalidCodonError if MAPPING[codon.join].nil?

      break proteins if MAPPING[codon.join] == :STOP

      proteins << MAPPING[codon.join]
    end
  end
end

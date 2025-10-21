class InvalidCodonError < StandardError; end

module Translation

  extend self

  MAPPING = {
    'AUG' => 'Methionine',
    'UUU' => 'Phenylalanine',
    'UUC' => 'Phenylalanine',
    'UUA' => 'Leucine',
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
  MAPPING.default_proc = proc { raise InvalidCodonError }

  def each_slice(sliceable, n)
    return to_enum(:each_slice, sliceable, n) unless block_given?

    (0...sliceable.length).step(n) { |i| yield sliceable[i, n] }
  end
  
  def of_rna(strand)
    each_slice(strand, 3).with_object([]) do |codon, proteins|
      protein = MAPPING[codon]

      break proteins if protein == :STOP

      proteins << protein
    end
  end

end

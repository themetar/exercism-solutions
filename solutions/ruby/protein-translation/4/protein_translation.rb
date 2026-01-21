class InvalidCodonError < StandardError; end

module Translation

  extend self

  MAPPING = proc do |codon|
    case codon
    when /AUG/ then 'Methionine'
    when /UU(U|C)/ then 'Phenylalanine'
    when /UU(A|G)/ then 'Leucine'
    when /UC(U|C|A|G)/ then 'Serine'
    when /UA(U|C)/ then 'Tyrosine'
    when /UG(U|C)/ then 'Cysteine'
    when /UGG/ then 'Tryptophan'
    when /U(A(A|G)|GA)/ then :STOP
    else
      raise InvalidCodonError
    end
  end

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

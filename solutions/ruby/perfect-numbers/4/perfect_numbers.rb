module PerfectNumber

  CLASSES = %w(perfect abundant deficient)

  def self.classify(number)
    raise ArgumentError, "Classification is only possible for positive integers." unless number.is_a?(Integer) && number > 0

    aliquot_sum = factors(number).sum

    CLASSES[aliquot_sum <=> number]
  end

  def self.factors(number)
    return to_enum(:factors, number) unless block_given?

    yield 1 unless number == 1

    (2..Math.sqrt(number)).each do |i|
      j, m = number.divmod i
      yield i if m.zero?
      yield j if m.zero? && j != i
    end
  end

end
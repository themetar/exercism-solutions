module PerfectNumber
  CLASSES = %w(perfect abundant deficient)

  def self.classify(number)
    raise RuntimeError unless number.is_a?(Integer) && number > 0

    aliquot_sum = (2..Math.sqrt(number)).reduce(1) do |sum, i|
      j, m = number.divmod i
      
      m.zero? ? sum + i + (j != i ? j : 0) : sum
    end

    CLASSES[aliquot_sum <=> number]
  end
end
module PerfectNumber
  def self.classify(number)
    raise RuntimeError unless number.is_a?(Integer) && number > 0

    aliquot_sum = (2...Math.sqrt(number)).reduce(1) do |sum, i|
      j, m = number.divmod i
      
      m.zero? ? sum + i + j : sum
    end

    return 'deficient' if aliquot_sum <  number
    return 'perfect'   if aliquot_sum == number
    return 'abundant'  if aliquot_sum >  number
  end
end
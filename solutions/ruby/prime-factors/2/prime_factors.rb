module PrimeFactors  
  def self.of(integer)
    factors = []
    divisor = 2
    
    while integer > 1
      while integer % divisor == 0
        factors << divisor
        integer /= divisor
      end
      divisor += 1
    end

    factors
  end    
end
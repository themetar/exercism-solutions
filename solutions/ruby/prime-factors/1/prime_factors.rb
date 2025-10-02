require 'prime'

module PrimeFactors  
  def self.of(integer)
    factors = []
    
    Prime.each do |prime|
      break if integer == 1
      
      while integer % prime == 0
        factors << prime
        integer /= prime
      end
    end

    factors
  end    
end
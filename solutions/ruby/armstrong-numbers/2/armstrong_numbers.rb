module ArmstrongNumbers
  def self.include?(number)
    digits = number.digits

    number == digits.reduce(0) { |acc, d| acc + d ** digits.length }    
  end
end

module ArmstrongNumbers
  def self.include?(number)
    digits = number.digits

    number == digits.sum { |d| d ** digits.length }    
  end
end

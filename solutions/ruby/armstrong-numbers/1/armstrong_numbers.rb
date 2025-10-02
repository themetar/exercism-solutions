module ArmstrongNumbers
  def self.include?(number)
    digits = []
    n = number
    while n > 0
      n, r = n.divmod 10
      digits << r
    end

    number == digits.reduce(0) { |acc, d| acc + d ** digits.length }    
  end
end

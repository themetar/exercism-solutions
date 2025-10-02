class Palindromes
  attr_reader :smallest, :largest
  
  def initialize(min_factor: 1, max_factor:)
    @min_factor = min_factor
    @max_factor = max_factor
  end

  def generate
    (@min_factor..@max_factor).each do |p1|
      (p1..@max_factor).each do |p2|
        number = p1 * p2
        if Palindromes.is_palindrome?(number)
          @smallest = Palindrome.new(number) if @smallest.nil? || number < @smallest.value 
          @largest = Palindrome.new(number) if @largest.nil? || number > @largest.value
          
          @smallest.add_factors([p1, p2]) if @smallest.value == number
          @largest.add_factors([p1, p2]) if @largest.value == number
        end
      end
    end
  end

  def self.is_palindrome?(number)
    copy = number
    reversed = 0
    until copy.zero?
      reversed = reversed * 10 + (copy % 10)
      copy /= 10
    end

    reversed == number
  end
end

class Palindrome
  attr_reader :value, :factors

  def initialize(number)
    @value = number
    @factors = []
  end

  def add_factors(pair)
    @factors << pair
  end
end

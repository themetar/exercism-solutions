class Palindromes
  Palindrome = Struct.new(:value, :factors)

  attr_reader :smallest, :largest
  
  def initialize(min_factor: 1, max_factor:)
    raise ArgumentError, "min must be <= max" unless min_factor <= max_factor

    @min_factor = min_factor
    @max_factor = max_factor
  end

  def generate
    lowest_value = @min_factor ** 2
    highest_value = @max_factor ** 2

    lowest_value.upto(highest_value).each do |candidate|
      next unless Palindromes.is_palindrome? candidate

      factors = factors(candidate)

      unless factors.empty?
        @smallest = Palindrome.new(candidate, factors)
        break
      end
    end

    @smallest ||= Palindrome.new(nil, [])

    highest_value.downto(lowest_value).each do |candidate|
      next unless Palindromes.is_palindrome? candidate
  
      factors = factors(candidate)
  
      unless factors.empty?
        @largest = Palindrome.new(candidate, factors)
        break
      end
    end

    @largest ||= Palindrome.new(nil, [])
  end

  def factors(number)
    (@min_factor..Math.sqrt(number)).each_with_object([]) do |factor, factors|
      other, mod = number.divmod factor
      factors << [factor, other] if mod.zero? && other.between?(@min_factor, @max_factor)
    end
  end

  def self.is_palindrome?(number)
    number.to_s === number.to_s.reverse
  end
end

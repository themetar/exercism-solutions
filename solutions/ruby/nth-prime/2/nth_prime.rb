module Prime

  def self.nth(n)
    raise ArgumentError if n < 1

    n -= 1  # zero-indexing
    
    primes.find.with_index { |_, index| index == n }
  end

  def self.primes
    return to_enum(:primes) unless block_given?

    2.step do |i|
      next if (2..Math.sqrt(i)).any? { |d| i % d == 0 }

      yield i
    end
  end

end

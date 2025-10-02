module CollatzConjecture
  def self.steps(n)
    raise ArgumentError if n < 1
    
    count = 0
    
    while n > 1
      n = n % 2 == 0 ? n / 2 : 3 * n + 1
      count += 1
    end
  
    count
  end
end

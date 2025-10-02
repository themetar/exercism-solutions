class Sieve
  def initialize(limit)
    @mask = Array.new(limit + 1, false)
    
    for integer in (2..limit) do
      next if @mask[integer]

      compound = integer
      
      until (compound += integer) > limit
        @mask[compound] = true
      end
    end
  end

  def primes
    @primes ||= (2...@mask.length).reject { |integer| @mask[integer] }
  end
end

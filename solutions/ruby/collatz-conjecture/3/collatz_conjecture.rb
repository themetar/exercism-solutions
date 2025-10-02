module CollatzConjecture
  def self.steps(n)
    raise ArgumentError if n < 1

    loop.count do
      raise StopIteration if n == 1
      n = n.even? ? n / 2 : 3 * n + 1
    end
  end
end

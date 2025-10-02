module PythagoreanTriplet
  def self.triplets_with_sum(n)
    triplets = []

    (1...(n / 3)).each do |a|
      b = (n**2 - 2 * n * a) / (2 * n - 2 * a)
      c = n - a - b
      triplets << [a, b, c] if a < b && b < c && a**2 + b**2 == c**2
    end

    triplets
  end  
end

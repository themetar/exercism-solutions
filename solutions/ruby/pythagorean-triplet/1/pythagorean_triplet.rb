module PythagoreanTriplet
  def self.triplets_with_sum(n)
    triplets = []

    (1...(n / 3)).each do |a|
      ((a + 1)..((n - a) / 2)).each do |b|
        c = n - a - b
        triplets << [a, b, c] if a**2 + b**2 == c**2
      end
    end

    triplets
  end  
end

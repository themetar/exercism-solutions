class Scrabble

  POINTS = Hash.new(0)
  %w(a e i o u l n r s t).each { |c| POINTS[c] = 1 }
  %w(d g).each { |c| POINTS[c] = 2 }
  %w(b c m p).each { |c| POINTS[c] = 3 }
  %w(f h v w y).each { |c| POINTS[c] = 4 }
  POINTS["k"] = 5
  %w(j x).each { |c| POINTS[c] = 8 }
  %w(q z).each { |c| POINTS[c] = 10 }

  def self.score(word)
    word.to_s.downcase.chars.collect { |c| POINTS[c] } .sum
  end

  def initialize(word)
    @word = word
  end

  def score
    Scrabble.score(@word)
  end

end

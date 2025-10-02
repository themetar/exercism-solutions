class Scrabble

  POINTS = {"aeioulnrst" => 1, "dg" => 2, "bcmp" => 3,
            "fhvwy" => 4, "k" => 5, "jx" => 8, "qz" => 10}.map { |letters, pts|
                letters.chars.zip([pts] * letters.length)
              } .flatten(1).to_h

  def self.score(word)
    word.to_s.downcase.chars.collect { |c| POINTS[c].to_i } .sum
  end

  def initialize(word)
    @word = word
  end

  def score
    Scrabble.score(@word)
  end

end

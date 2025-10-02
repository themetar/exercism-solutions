class Scrabble

  POINTS = {
    "aeioulnrst" => 1,
    "dg" => 2,
    "bcmp" => 3,
    "fhvwy" => 4,
    "k" => 5,
    "jx" => 8,
    "qz" => 10
  }.map { |letters, pts|
    letters.chars.product([pts])
  }.flatten(1).to_h

  def initialize(word)
    @word = word.downcase
  end

  def score
    @word.chars.sum(&POINTS)
  end

end

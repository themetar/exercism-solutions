class Phrase

  PATTERN = /\w+(?:'?\w+)*/

  def word_count
    words.tally
  end

  private

  attr_accessor :phrase

  def initialize(phrase)
    self.phrase = phrase
  end

  def words
    phrase.downcase.scan(PATTERN)
  end

end

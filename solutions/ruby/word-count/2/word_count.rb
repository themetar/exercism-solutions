class Phrase
  PATTERN = /\w+(?:'?\w+)*|\d+/

  def initialize(phrase)
    @phrase = phrase
  end

  def word_count
    words.each_with_object(Hash.new(0)) { |word, hash| hash[word] += 1 }
  end

  private

  attr_reader :phrase

  def words
    phrase.downcase.scan(PATTERN)
  end
end

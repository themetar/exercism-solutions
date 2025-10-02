class Anagram

  def initialize(word)
    @downcased = word.downcase
    @normalized = sorted_letters(@downcased)
  end

  def match(candidates)
    candidates
      .reject { |candidate| candidate.downcase == @downcased }
      .select { |candidate| @normalized == sorted_letters(candidate.downcase) }
  end

  private

  def sorted_letters(word)
    word.chars.sort
  end

end

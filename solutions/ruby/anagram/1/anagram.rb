class Anagram
  def initialize(word)
    @word = word
    @normalized = sorted_letters(word.downcase)
  end

  def match(candidates)
    candidates
      .reject { |candidate| candidate.downcase == @word.downcase }
      .select { |candidate| @normalized == sorted_letters(candidate.downcase) }
  end

  private

    def sorted_letters(word)
      word.split('').sort
    end
end

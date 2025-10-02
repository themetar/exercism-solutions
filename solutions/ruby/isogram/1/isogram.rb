class Isogram
  def Isogram.isogram?(phrase)
    word_characters = phrase.downcase.scan(/\w/)
    return word_characters.length == word_characters.uniq.length
  end
end

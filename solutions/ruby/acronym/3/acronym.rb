class Acronym
  def Acronym.abbreviate(phrase)
    phrase.scan(/\b\w/).join.upcase
  end
end

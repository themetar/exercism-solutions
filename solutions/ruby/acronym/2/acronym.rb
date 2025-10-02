class Acronym
  def Acronym.abbreviate(phrase)
    phrase.scan(/\b\w/).collect(&:upcase).join("")
  end
end

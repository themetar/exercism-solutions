class Acronym

  def Acronym.abbreviate(phrase)

    phrase.scan(/(?<=^|_|-|\s)[a-zA-Z]/).join.upcase

  end

end


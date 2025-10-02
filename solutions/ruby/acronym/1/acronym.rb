class Acronym
  def Acronym.abbreviate(phrase)
    phrase.split(/[^[:alpha:]]+/).collect {|word| word[0].upcase} .join("")
  end
end

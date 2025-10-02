class Isogram
  def Isogram.isogram?(phrase)
    phrase !~ /([a-z]).*\1/i
  end
end

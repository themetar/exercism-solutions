class Raindrops
  def self.convert(int)
    out = ""
    if int % 3 == 0 then out += "Pling" end
    if int % 5 == 0 then out += "Plang" end
    if int % 7 == 0 then out += "Plong" end
    if out.empty? then out = int.to_s end

    out
  end
end

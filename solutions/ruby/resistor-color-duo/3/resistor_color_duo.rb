class ResistorColorDuo
  DIGITS = {
    "black"  => 0,
    "brown"  => 1,
    "red"    => 2,
    "orange" => 3,
    "yellow" => 4,
    "green"  => 5,
    "blue"   => 6,
    "violet" => 7,
    "grey"   => 8,
    "white"  => 9
  }

  def self.value(codes)
    color_0, color_1 = codes
    DIGITS[color_0] * 10 + DIGITS[color_1]
  end
end

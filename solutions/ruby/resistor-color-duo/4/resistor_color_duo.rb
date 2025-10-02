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
    digit_1, digit_0 = codes.first(2).map(&DIGITS)
    digit_1 * 10 + digit_0
  end
end

class ResistorColorDuo
  VALUES_HASH = {
    "black"  => 0,
    "brown"  => 1,
    "red"    => 2,
    "orange" => 3,
    "yellow" => 4,
    "green"  => 5,
    "blue"   => 6,
    "violet" => 7,
    "grey"   => 8,
    "white"  => 9,
  }

  def self.value(codes)
    VALUES_HASH[codes[0]] * 10 + VALUES_HASH[codes[1]]
  end
end
